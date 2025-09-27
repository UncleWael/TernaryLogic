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



## 🛠 Contribute
Contributions, issues, and feature requests are welcome! Feel free to open an issue or submit a pull request.

### Reporting Bugs
- Open an [issue](../../issues) and use a clear, descriptive title.  
- Include steps to reproduce, expected behavior, and actual behavior.  
- Add Delphi version and operating system info if relevant.  

### Suggesting Features
- Open an [issue](../../issues) with the label `enhancement`.  
- Clearly describe the problem your feature would solve.  
- If possible, provide examples or pseudo-code.  

### Submitting Code Changes
1. Fork the repository.  
2. Create a feature branch:  
   ```bash
   git checkout -b feature/my-feature
```

## 📄 License
This project is licensed under the [MIT License](LICENSE).
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
