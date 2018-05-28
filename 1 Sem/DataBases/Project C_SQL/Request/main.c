#include "sqlite3.h"
#include <stdio.h>
#include <string.h>
#include<assert.h>
#include<stdio.h>
#include<stdlib.h>

void Request(int ID, const char text[], const char sSql[]) {
	const char *pTail;
	int nColumnCnt;
	sqlite3* db;
	int err;
	sqlite3_stmt *st;
	int numb;

	err = sqlite3_open("req.db", &db);
	if (err) __debugbreak();
	err = sqlite3_prepare_v2(
		db,
		sSql,
		-1,
		&st,
		&pTail
	);
	if (err != SQLITE_OK)
	{
		printf("%s\n", sqlite3_errmsg(db));
		__debugbreak();
	}

	err = sqlite3_bind_int(st, 1, ID);
	if (err) __debugbreak();

	nColumnCnt = sqlite3_column_count(st);
	while ((err = sqlite3_step(st)) == SQLITE_ROW) {
		for (int i = 0; i < nColumnCnt; i++) {
			printf("%s: ", text);
			printf(sqlite3_column_text(st, i));
		}
		printf("\n");
	}
	if (err != SQLITE_DONE) __debugbreak();
	sqlite3_finalize(st);
}

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
	printf("%10s  %10s   %10s\n", "ID", "Name", "Capacity");
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
				printf("%10s   ", sqlite3_column_text(st, i));
			}
			printf("\n");
		}
		if (err != SQLITE_DONE) __debugbreak();
		sqlite3_finalize(st);
	}

	const char sSql[] = "SELECT COUNT(*) FROM Tenants WHERE HotelID = ?";
	const char sSql1[] = "SELECT Capacity FROM Hotels WHERE HotelID = ?";
	int ID;

	printf("%s ", "HotelID:");
	scanf_s("%d", &ID);

	Request(ID, "Number of guests", sSql);
	Request(ID, "Capacity", sSql1);

	sqlite3_close(db);
	printf("\n");
	system("pause");
}