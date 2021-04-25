# connect to keboola snowflake via jupyter

from sqlalchemy import create_engine
from snowflake.sqlalchemy import URL
from sqlalchemy.dialects import registry

registry.register('snowflake', 'snowflake.sqlalchemy', 'dialect')

url = URL(user='workspace',
          password='password',
          account='account',
          database='database',
          schema='workspace')

engine = create_engine(url)

connection = engine.connect()
