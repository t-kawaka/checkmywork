# checkmywork 構造

#### userモデル

#### |カラム名 : データ型  |
#### |---|
#### |user : string  |

#### taskモデル

#### |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |
#### |---|---|---|---|---|---|
#### |name : string  |detail : text  |deadline : datetime  |situation : string  |priority : string  |user : references  |

#### labelモデル

#### |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |カラム名 : データ型  |
#### |---|---|---|---|
#### |label1 : string  |label2 : string  |label3 : string  |task : references  |
