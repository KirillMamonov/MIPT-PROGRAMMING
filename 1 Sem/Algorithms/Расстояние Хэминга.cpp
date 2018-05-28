/*Определим расстояние от шаблона p до строки s как суммарное расстояние
Хэмминга от p до всех подстрок s, имеющих длину p. В строке и в шаблоне 
некоторые символы стёрты. Нужно восстановить стёртые символы так, чтобы 
расстояние от p до s было минимально возможным.

Строим статистику по кол-ву 0, 1, ? в большей строке, пробегаясь по меньшей,
строим граф из истока 0, стока 1 и связаных вопросов. Применяя алгоритм Диницы,
находим максимальный поток в этом графе, проходим BFS по остаточной сети,
разделяя ? на 0 и 1.

Время: 56ms
Память: 15.68Mb*/

#include<iostream>
#include<vector>
#include<queue>
#include<algorithm>
#include <string>

using namespace std;

class Graph {
	int size;
	vector<vector<int16_t>> graph;

public:
	Graph(int16_t countVert) : size(countVert), graph(size, vector<int16_t> (size)) {}
	
	Graph() : graph(0) {}

	void AddEdge(int16_t from, int16_t to, int16_t weight) {
		graph[from][to] += weight;
	}

	bool ExisEdge(int16_t from, int16_t to) const{
		return graph[from][to] != 0;
	}

	int16_t Size() const { return size; }

	const vector<int16_t>& operator[](const int16_t& i) const { return graph[i]; }

	Graph& operator = (Graph& g) {
		graph = g.graph;
		size = g.size;
		return*this;
	}

	Graph(const Graph&) = delete;

	~Graph() {};
};

class Solution {
	int resFlow;
	Graph residual;
	vector<pair<bool, int>> question;
	string n;
	string m;

	bool bfs(Graph &source, Graph &flows, vector<int> &deeps) const { //Для Диницы
		int n = source.Size();
		queue<int> que;
		que.push(0);
		deeps.assign(n, -1);
		deeps[0] = 0;
		while (!que.empty()) {
			int vert = que.front();
			que.pop();
			for (int i = 0; i < source[vert].size(); ++i)
				if (source[vert][i] > flows[vert][i] && deeps[i] == -1) {
					deeps[i] = deeps[vert] + 1;
					que.push(i);
				}
		}
		return deeps[1] != -1;
	}

	int dfs(int vert, int flow, Graph &source, Graph &flows, vector<int> &deeps, vector<int>& startVert) const {
		int n = source.Size();
		if (!flow) return 0;
		if (vert == 1) return flow;
		for (int& i = startVert[vert]; i < n; ++i) {
			if (deeps[i] != deeps[vert] + 1) continue;
			int delta = dfs(i, min(flow, source[vert][i] - flows[vert][i]), source, flows, deeps, startVert);
			if (delta) {
				flows.AddEdge(vert, i, delta);
				flows.AddEdge(i, vert, -delta);
				if (!source.ExisEdge(i, vert)) source.AddEdge(i, vert, 0);
				return delta;
			}
		}
		return 0;
	}

	void BFS(Graph &source, Graph& flow) {	//Для обхода по остаточной сети и присвоение ?: 0 или 1
		int len = source.Size();
		queue<int> que;
		vector<bool> vertices(len);
		que.push(0);
		vertices[0] = true;
		while (!que.empty()) {
			int vert = que.front();
			que.pop();
			for (int i = 0; i < len; ++i)
				if (!vertices[i] && source[vert][i] != flow[vert][i]) {
					que.push(i);
					vertices[i] = true;
				}
		}
		for (int i = 2; i < len; ++i) {
			if (question[i - 2].first) n[question[i - 2].second] = vertices[i] ? '0' : '1';
			else m[question[i - 2].second] = vertices[i] ? '0' : '1';
		}
	}

	Graph& MakeGraph(Graph& res) {
		int ms = m.size();
		int ns = n.size();
		int countQest = 2;			//Номер ? как вершины графа
		vector<int> quesN(ns, -1);
		vector<int> questM(ms, -1);
		vector<vector<int>> pref(ns, vector<int>(3, 0));
		for (int i = 0; i < ns; ++i) {		//Проходимся по префиксам большей строки, считаем кол-во 0,1,?
			if (i != 0) pref[i] = pref[i - 1];
			switch (n[i]) {
			case '0':
				pref[i][0]++;
				break;
			case '1':
				pref[i][1]++;
				break;
			case '?':
				pref[i][2]++;
				quesN[i] = countQest;
				question[-2 + countQest++] = make_pair(true, i);
				break;
			}
		}
		for (int i = 0; i < ms; ++i) if (m[i] == '?') {
			questM[i] = countQest;
			question[-2 + countQest++] = make_pair(false, i);
		}
		Graph graph(countQest);
		question.resize(countQest - 2);
		vector<int> temp(3);
		for (int i = 0; i < ms; i++) {	//Пробегаемся по меньшей строке и, сравнивая с префиксами большей, строим граф
			int right, left;
			if (i != 0) {
				for (int j = 0; j < 3; ++j) temp[j] = pref[i + ns - ms][j] - pref[i - 1][j];
				left = pref[i - 1][2];
			}
			else {
				for (int j = 0; j < 3; ++j) temp[j] = pref[ns - ms][j];
				left = 0;
			}
			right = pref[i + ns - ms][2];
			switch (m[i]) {
			case '0':
				resFlow += temp[1];
				for (int j = left + 2; j < right + 2; ++j) graph.AddEdge(0, j, 1);
				break;
			case '1':
				resFlow += temp[0];
				for (int j = left + 2; j < right + 2; ++j) graph.AddEdge(j, 1, 1);
				break;
			case '?':
				if (temp[1] != 0) graph.AddEdge(questM[i], 1, temp[1]);
				if (temp[0] != 0) graph.AddEdge(0, questM[i], temp[0]);
				for (int j = left + 2; j < right + 2; ++j) {
					graph.AddEdge(questM[i], j, 1);
					graph.AddEdge(j, questM[i], 1);
				}
				break;
			}
		}
		res = graph;
		return res;
	}

	void Solve(Graph& graph) {
		int n = graph.Size();	//Диница
		vector<int> deep(n);
		Graph flow(n);
		while (true) {
			if (!bfs(graph, flow, deep)) break;
			vector<int> startVert(n, 0);
			int delta = dfs(0, 2000000, graph, flow, deep, startVert);
			while (delta) {
				resFlow += delta;
				delta = dfs(0, 2000000, graph, flow, deep, startVert);
			}
		}
		BFS(graph, flow);	//Конечный обход остаточной сети
	};

public:
	const pair<string, string> GetStr() const { return make_pair(n, m); }

	Solution(){}

	Solution(string n, string m) : n(n), m(m), resFlow(0), question(m.size() + n.size()) {
		Graph graph;
		Solve(MakeGraph(graph));
	}

	friend istream& operator >> (istream& cin, Solution& graph) {
		string n;
		string m;
		getline(cin, n);
		getline(cin, m);
		Solution temp(n, m);
		graph = temp;
		return cin;
	}

	friend ostream& operator << (ostream& cout, Solution& res) {
		cout << res.resFlow << endl;
		pair<string, string> Str = res.GetStr();
		cout << Str.first << endl;
		cout << Str.second << endl;
		return cout;
	}

	Solution(const Solution&) = delete;

	~Solution() {}
};

int main() {
	Solution graph;
	cin >> graph;
	cout << graph;
	system("pause");
}