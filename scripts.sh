function download_py_project_files(){
	wget --quiet --show-progress -O .gitignore "https://raw.githubusercontent.com/lephattan/python-project-template/master/.gitignore"
	wget --quiet --show-progress -O pyproject.toml "https://raw.githubusercontent.com/lephattan/python-project-template/master/pyproject.toml"
	wget --quiet --show-progress -O .pre-commit-config.yaml "https://raw.githubusercontent.com/lephattan/python-project-template/master/.pre-commit-config.yaml"
	wget --quiet --show-progress -O .flake8 "https://raw.githubusercontent.com/lephattan/python-project-template/master/.flake8"
}

function init_py_project(){
	python3 -m venv env --prompt $1
  touch requirements.in
  touch requirements.txt
	touch main.py
  mkdir tests/
  touch tests/__init__.py
}

function init_git(){
	git init .
	git add .
	git commit -m "Init commit"
  pre-commit install
}
function create-python (){
	mkdir $1
	cd $1
  download_py_project_files
  init_py_project $1
  init_git
	echo "$1 created sucessfully!"
}

function set-env (){
	if test -f $1; then
		# Show env vars
		#grep -v '^#' $1

		# Export env vars
		export $(grep -v '^#' $1 | xargs)
		echo "Envs loaded from $1!"
	else
		echo "Could not find $1"
	fi
}

function get_env_path(){
  EnvsPath="${PYTHON_ENVS:-$HOME/.envs}";
  readlink -e "$EnvsPath";
}

function ls_env(){
  env_path=$(get_env_path);
  ls -la $env_path;
}

function create_env() {
  envs_path=$(get_env_path);
  env_path="$envs_path/$1"
  python3.8 -m venv $env_path --prompt $1 && 
  echo $env_path;
}

function ac_local(){
  source env/bin/activate;
}

function ac_env(){
  env_path=$(get_env_path);
  source "$env_path/$1/bin/activate";
}

function ac(){
  if ! [ -z "$1" ]; then
    ac_env $1;
  else
    ac_local;
  fi
}
