#include"sqlite3.h"
#include<assert.h>
#include<stdio.h>
#include<stdlib.h>

int main(void) {
	FILE *f;
	long nSize;
	void *pData;
	int i;

	fopen_s(&f, "req.SQL", "rb");
	if (!f) __debugbreak();

	fseek(f, 0, SEEK_END);
	nSize = ftell(f);

	pData = malloc(nSize);
	if (!pData) __debugbreak();

	fseek(f, 0, SEEK_SET);
	i = fread(pData, nSize, 1, f);
	assert(i == 1);

	int err;
	const char *pSqlEnd;
	sqlite3* db;
	const char *sSqlPos;
	err = sqlite3_open("req.db", &db);
	sqlite3_stmt *st;
	if (err != SQLITE_OK) __debugbreak();
	sSqlPos = pData;
	pSqlEnd = sSqlPos + nSize;
	for (;;) {
		err = sqlite3_prepare(db, sSqlPos, (pSqlEnd - sSqlPos), &st, &sSqlPos);
		if (err != SQLITE_OK)
		{
			printf("%s\n", sqlite3_errmsg(db));
			__debugbreak();
		}

		if (!st) break;
		int col_cnt = sqlite3_column_count(st);
		while ((err = sqlite3_step(st)) == SQLITE_ROW) {
			for (int i = 0; i < col_cnt; i++) {
				printf("%s", sqlite3_column_text(st, i));
			}
			printf("\n");
		}
		if (err != SQLITE_DONE) __debugbreak();
		sqlite3_finalize(st);
	}
	sqlite3_close(db);
	system("pause");
}