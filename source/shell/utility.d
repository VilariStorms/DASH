import std.process;

string get_user() {
    version (Posix) {
        return environment.get("USER");
    }

    version (Windows) {
        return environment.get("USERNAME");
    }
}