from logging import basicConfig, getLogger, INFO

from botocore.exceptions import ClientError

from pyqldb.driver.qldb_driver import QldbDriver
from fastapi_qldb.constants import Constants

logger = getLogger(__name__)
basicConfig(level=INFO)


def create_qldb_driver(ledger_name=Constants.LEDGER_NAME, region_name=Constants.REGION, endpoint_url=None, boto3_session=None):

    qldb_driver = QldbDriver(ledger_name=ledger_name, region_name=region_name, endpoint_url=endpoint_url,
                             boto3_session=boto3_session)
    return qldb_driver


def list_ledger_tables(ledger_name=Constants.LEDGER_NAME):

    try:
        tables = []
        with create_qldb_driver(ledger_name) as driver:
            logger.info('Listing table names ')
            for table in driver.list_tables():
                tables.append(table)
    except ClientError as ce:
        logger.exception('Unable to list tables.')
        raise ce
    return tables
