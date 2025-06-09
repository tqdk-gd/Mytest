import pymysql
import configparser

class DBConnector:
    def __init__(self, config_file):
        self.config = configparser.ConfigParser()
        self.config.read(config_file)
        self.connection = None
        self.cursor = None

    def connect(self):
        host = self.config.get('database1', 'host')
        user = self.config.get('database1', 'user')
        password = self.config.get('database1', 'password')
        database = self.config.get('database1', 'database')

        self.connection = pymysql.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )
        self.cursor = self.connection.cursor()

    def close(self):
        try:
            if self.connection:
                self.connection.close()
            if self.cursor:
                self.cursor.close() 
        except Exception:
            pass  # 忽略可能出现的异常，直接强制关闭

    def query(self, sql,values=None):
        try:
            self.connect()
            if values:
                self.cursor.execute(sql, values)
            else:
                self.cursor.execute(sql)
            result = self.cursor.fetchall()
            return result
        except Exception as e:
            print(f"执行查询出错: {e}")
            return []
        # finally:
        #     self.close()

    def commit(self):
        try:
            if self.connection and self.connection.open:
                self.connection.commit()
            else:
                print("数据库连接未建立或已关闭，无法提交事务。")
        except Exception as e:
            print(f"提交事务时出错: {e}")
            try:
                # 尝试重新连接并再次提交
                self.connect()
                self.connection.commit()
            except Exception as reconnect_e:
                print(f"重新连接并提交事务失败: {reconnect_e}")


# 使用示例
# db = DBConnector('config.ini')
# sql_query = "SELECT * FROM web_app"
# result = db.query(sql_query)

# if result is not None:
#     for row in result:
#         print(row)

