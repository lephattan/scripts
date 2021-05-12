function create-python (){
	mkdir $1
	cd $1
	python3 -m venv env --prompt $1
	git init .
	wget -O .gitignore "https://raw.githubusercontent.com/github/gitignore/master/Python.gitignore"
	echo "env/" >> .gitignore
	touch main.py
	git add .
	git commit -m "Init commit"
	echo "{$1} created sucessfully!"
}
