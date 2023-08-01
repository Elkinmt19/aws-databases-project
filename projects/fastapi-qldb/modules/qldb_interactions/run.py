from fastapi import FastAPI, HTTPException
from fastapi.staticfiles import StaticFiles
from fastapi.params import Query
from fastapi_qldb import ddl_qldb, connect_to_ledger, insert_documents, export_job
import botocore.exceptions

app = FastAPI(
    title="QLDB Wallet",
    description="""
    Verify Data stored in a QLDB ledger for different users.
    
    Sample Ledger Name:
        pragma-ledger-qldb-project-dev
        
    Indexing:
                TABLE                 INDEX
        =============================================
        VehicleRegistration : LicensePlateNumber, VIN
        Vehicle             : VIN
        Person              : GovId
        DriversLicense      : PersonId, LicenseNumber
    }
    
    AWS Region: 
        us-east-1
    
    """,
    version="1.0.0",
)


@app.post("/api/create_ledger", tags=["CRUD QDLB"])
async def call_create_ledger(ledger_name: str):
    try:
        ddl_qldb.create_ledger(ledger_name=ledger_name)

    except botocore.exceptions.ClientError as e:
        error_code = e.response["Error"]["Code"]
        if error_code == "ResourceAlreadyExistsException":
            raise HTTPException(
                status_code=400, detail=e.response["Error"]["Message"])
        else:
            raise HTTPException(
                status_code=500, detail="Internal Server Error")


@app.post("/api/create_table", tags=["CRUD QDLB"])
async def call_create_table(ledger_name: str, table_name: str):
    try:
        ddl_qldb.create_table(ledger_name=ledger_name, table_name=table_name)
        return f'Table {table_name} created successfully.'

    except botocore.exceptions.ClientError as e:
        error_code = e.response["Error"]["Code"]
        if error_code == "BadRequestException":
            raise HTTPException(
                status_code=400, detail=e.response["Error"]["Message"])
        else:
            raise HTTPException(
                status_code=500, detail="Internal Server Error")


@app.post("/api/create_index", tags=["CRUD QDLB"])
async def call_create_index(ledger_name: str, table_name: str, index_name: str):
    try:
        ddl_qldb.create_index(ledger_name=ledger_name,
                              table_name=table_name, index_name=index_name)
        return f'Index {table_name}.{index_name} created successfully.'

    except botocore.exceptions.ClientError as e:
        error_code = e.response["Error"]["Code"]
        if error_code == "BadRequestException":
            raise HTTPException(
                status_code=400, detail=e.response["Error"]["Message"])
        else:
            raise HTTPException(
                status_code=500, detail="Internal Server Error")


@app.delete("/api/delete_table", tags=["CRUD QDLB"])
async def call_delete_table(ledger_name: str, table_name: str):
    try:
        ddl_qldb.delete_table(ledger_name=ledger_name, table_name=table_name)

    except botocore.exceptions.ClientError as e:
        error_code = e.response["Error"]["Code"]
        if error_code == "BadRequestException":
            raise HTTPException(
                status_code=400, detail=e.response["Error"]["Message"])
        else:
            raise HTTPException(
                status_code=500, detail="Internal Server Error")


@app.get("/api/list_tables", tags=["CRUD QDLB"])
async def call_list_tables(ledger_name: str):
    try:
        tables = connect_to_ledger.list_ledger_tables(ledger_name=ledger_name)

    except botocore.exceptions.ClientError as e:
        error_code = e.response["Error"]["Code"]
        if error_code == "BadRequestException":
            raise HTTPException(
                status_code=400, detail=e.response["Error"]["Message"])
        else:
            raise HTTPException(
                status_code=500, detail="Internal Server Error")
    return tables


@app.post("/api/insert_sample_documents", tags=["ION DOCUMENTS"])
async def call_insert_docs(ledger_name: str):
    try:
        insert_documents.update_and_insert_documents(ledger_name=ledger_name)
        return 'sample data inserted succesfully'
    except botocore.exceptions.ClientError as e:
        error_code = e.response["Error"]["Code"]
        if error_code == "BadRequestException":
            raise HTTPException(
                status_code=400, detail=e.response["Error"]["Message"])
        else:
            raise HTTPException(
                status_code=500, detail="Internal Server Error")


@app.post("/api/start_export_job", tags=["S3 Export"])
async def call_export_job(ledger_name: str):
    try:
        export_job.start_export_job(ledger_name=ledger_name)
        return 'Data exported succesfully'
    except botocore.exceptions.ClientError as e:
        error_code = e.response["Error"]["Code"]
        if error_code == "BadRequestException":
            raise HTTPException(
                status_code=400, detail=e.response["Error"]["Message"])
        else:
            raise HTTPException(
                status_code=500, detail="Internal Server Error")
