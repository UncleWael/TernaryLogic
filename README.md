# Ternary Logic for Delphi

**Ternary Logic for Delphi** library provides an implementation of  **the three-valued logic** for the Delphi Object Pascal language.  
It defines the necessary logical types, reasoning operators, and utility functions that extend the built-in Boolean logic into a three-state domain.

## ✨ Features
- TTernaryValue type that represents the three logic values : `T` (True) `F` (False)  , and `N` (Neutral/Unknown/Intermeidate)  
- Overloaded Delphi logical operators (`and`, `or`, `xor`, `not`, `implies`, etc.) for ternary reasoning.  
- Utility functions for conversions to/from standard `Boolean`, strings and integer.  
- Designed to feel natural in Delphi, with operator overloading and managed record features.

## 🛠 Requirements
- Delphi **10.4 Sydney** or later.
- No external dependencies.

## 🚀 Getting Started

```delphi
	uses
		TernaryLogic;

	procedure TestTernary;
	var
	p,q,r:TTernaryLogic;
	begin
	p.Framework:=fKleene;
	q.Framework:=fKleene;

	p.Value:=N;
	q.Value:=T;

	r := p and q
	showmessage(r.toString);
	end;
```

## 📦 Installation
Clone or download this repository and add the TernaryLogic.pas file to your Delphi project’s search path.

```bash
git clone https://github.com/UncleWael/TernaryLogic.git
```

## 📄 License
This project is licensed under the [MIT License](LICENSE).
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)



