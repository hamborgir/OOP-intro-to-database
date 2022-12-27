OOP_GSLC-S10

Nama: Ilham Hadi Shahputra
NIM: 2502042164
Kelas: LA06

Saya akan menggunakan game gacha 'Arknights' sebagai contoh untuk menunjukan penyimpanan game state atau player progress menggunakan relational database (berdasarkan interpretasi saya--bisa jadi berbeda dengan cara penyimpanan pada game aslinya). File .sql dibuat menggunakan sql phpMyAdmin.


# Arknights (Database)

## player (Table)
"""
Tabel ini menyimpan informasi akun player seperti unique identifier playerID yang membedakan satu player dengan lainnya. Tabel ini berisi informasi spesifik terkait masing-masing playerID seperti playerLevel (int), lastLogin (timeStamp), serta in-game currency seperti LMD (int), orundum (int), dan orPrime (int).
"""

```
table player {
	playerID char(8) ~PK
	playerLevel int
	lastLogin timestamp
	lmd int
	orundum int
	orPrime int
}
```

## player_units (Table)
"""
Tabel ini berfungsi untuk menunjukan unit (character) apa saja yang dimiliki tiap player beserta level (int: 1 - unit_attr.maxLevel), promotion (string: E0, E1, E2), dan trust (int: 0 - 200) unit player yang bergantung progress masing-masing player. Tabel ini juga juga mereferensikan unitID pada tabel unit_attr dan playerID pada tabel player.
"""

```
table player_units {
	playerID char(8) [ref: > player.playerID] ~CK, FK
	unitID int [ref: > unit.unitID] ~CK, FK
	unitLevel int
	promotion varchar
	trust int
}
```

## player_profile (Table)
"""
Tabel ini berisi informasi publik mengenai playerID yang dapat dilihat oleh playerID lain seperti playerName (nama akun), tags (int friend tag), dan unit favorit player.
"""

```
table player_profile {
	playerID char(8) [ref: > player.playerID] ~PK, FK
	playerName varchar
	tags int
	favUnit int [ref: > unit.unitID] ~FK
}
```

## player_friends (Table)
"""
Ini adalah tabel yang menyimpan data relasi pertemanan antar playerID.
"""

```
table player_friends {
	playerID char(8) [ref: <> player_profile.playerID] ~PK, FK
	friendID char(8) [ref:<> player_profile.playerID] ~FK
}
```

## unit (Table)
"""
Tabel ini berfungsi untuk menyimpan informasi umum semua unit yang ada di game Arknights seperti nama unit (string), rarity (int: 1-6 stars), maxLevel (int), module_available (bool: 0-1). ~~Saat ini, hanya ada beberapa informasi unit yang tersimpan.
"""

```
table unit {
	unitID int ~PK
	unitName varchar
	rarity int
	maxLevel int
	module_available boolean
}
```

## player_base (Table)
"""
Tabel ini berfungsi menyimpan progress base dari player. Karena player dapat bebas memilih di mana saja mereka ingin membangun building di base, maka PK baseSlotNumber digunakan untuk merujuk letak building dibangun pada base. Misalnya, baseSlotNumber = 1 adalah tempat paling kiri atas dan baseSlotNumber = 6 terletak di bawah baseSlotNumber = 1. Data di tabel terdapat buildingName (string: Trading Post, Factory, Power Plant, Dormitory, ...), buildingLevel (int: 0-5), assignedUnit1 (string), assignedUnit2 (string), assignedUnit3 (string). assignedUnit adalah unit yang sedang beroperasi dalam building.
"""

```
table player_base {
	playerID char(8) [ref: > player.playerID] ~CK, FK
	baseSlotNumber int ~CK
	buildingName varchar
	buildingLevel int
	assignedUnit1 varchar
	assignedUnit2 varchar
	assignedUnit3 varchar
}
```