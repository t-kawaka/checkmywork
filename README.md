# checkmywork 構造

#### userモデル

|カラム名 : データ型  |
|---|
|user : string  |

#### taskモデル

|カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |
|---|---|---|---|---|---|
|name : string  |detail : text  |deadline : datetime  |situation : string  |priority : string  |user : references  |

#### missionモデル
|カラム名 : データ型  |
|---|---|
|task_id : integer  |label_id : integer  |

#### labelモデル

|カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |
|---|---|---|---|
|label1 : string  |label2 : string  |label3 : string  |task : references  |

![ER図](/docs/ER図.png)
