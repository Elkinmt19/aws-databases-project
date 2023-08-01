from time import sleep
from boto3 import client
from logging import basicConfig, getLogger, INFO

from fastapi_qldb.constants import Constants
from fastapi_qldb.connect_to_ledger import create_qldb_driver

logger = getLogger(__name__)
basicConfig(level=INFO)
qldb_client = client('qldb')

LEDGER_CREATION_POLL_PERIOD_SEC = 10
ACTIVE_STATE = "ACTIVE"


def _create_ledger(name):
    logger.info("Let's create the ledger named: {}...".format(name))
    result = qldb_client.create_ledger(Name=name, PermissionsMode='STANDARD')
    logger.info('Success. Ledger state: {}.'.format(result.get('State')))
    return result


def wait_for_active(name):
    logger.info('Waiting for ledger to become active...')
    while True:
        result = qldb_client.describe_ledger(Name=name)
        if result.get('State') == ACTIVE_STATE:
            logger.info('Success. Ledger is active and ready to use.')
            return result
        logger.info('The ledger is still creating. Please wait...')
        sleep(LEDGER_CREATION_POLL_PERIOD_SEC)


def create_ledger(ledger_name):  # ledger_name=Constants.LEDGER_NAME):

    try:
        _create_ledger(ledger_name)
        wait_for_active(ledger_name)
    except Exception as e:
        logger.exception('Unable to create the ledger!')
        raise e


def _create_table(driver, table_name):
    logger.info("Creating the '{}' table...".format(table_name))
    statement = 'CREATE TABLE {}'.format(table_name)
    cursor = driver.execute_lambda(
        lambda executor: executor.execute_statement(statement))
    logger.info('{} table created successfully.'.format(table_name))
    return len(list(cursor))


def create_table(ledger_name=Constants.LEDGER_NAME, table_name=None):
    try:
        with create_qldb_driver(ledger_name) as driver:
            _create_table(driver, table_name)
            logger.info('Table created successfully.')
    except Exception as e:
        logger.exception('Errors creating tables.')
        raise e


def _delete_table(driver, table_name):
    logger.info("Deleting the '{}' table...".format(table_name))
    statement = 'DROP TABLE {}'.format(table_name)
    cursor = driver.execute_lambda(
        lambda executor: executor.execute_statement(statement))
    logger.info('{} table deleted successfully.'.format(table_name))
    return len(list(cursor))


def delete_table(ledger_name=Constants.LEDGER_NAME, table_name=None):
    try:
        with create_qldb_driver(ledger_name) as driver:
            _delete_table(driver, table_name)
            logger.info('Table deleted successfully.')
    except Exception as e:
        logger.exception('Errors deleting tables.')
        raise e


def _create_index(driver, table_name, index_attribute):
    logger.info("Creating index on '{}'...".format(index_attribute))
    statement = 'CREATE INDEX on {} ({})'.format(table_name, index_attribute)
    cursor = driver.execute_lambda(
        lambda executor: executor.execute_statement(statement))
    return len(list(cursor))


def create_index(ledger_name=Constants.LEDGER_NAME, table_name=None, index_name=None):
    logger.info('Creating indexes on all tables...')
    try:
        with create_qldb_driver(ledger_name) as driver:
            _create_index(driver, table_name, index_name)
            logger.info('Index created successfully.')
    except Exception as e:
        logger.exception('Unable to create index.')
        raise e
