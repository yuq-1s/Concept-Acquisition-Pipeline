build:
	g++ -g myst.cc -std=c++1z -O3 -Wl,-undefined,dynamic_lookup -shared -fPIC `python3 -m pybind11 --includes` -o suffix_tree`python3-config --extension-suffix` -I${HOME}/.local/include  -stdlib=libc++
