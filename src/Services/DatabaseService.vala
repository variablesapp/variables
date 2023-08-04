
public class Variables.DatabaseService : GLib.Object {
    public Gda.Connection connection;

    private const string DATABASE_FILENAME = "data";
    private const string DATABASE_FULL_FILENAME = DATABASE_FILENAME + ".db";
    private string database_directory;
    private string database_path;

    construct {
        database_directory = GLib.Environment.get_user_data_dir ();
        print ("Database Directory: %s\n", database_directory);
        database_path = database_directory + "/" + DATABASE_FULL_FILENAME;
    }

    /**
    * Intiialises the database
    */
    public void init () throws Error {
        var database_file = File.new_for_path (database_path);
        this.connection = Gda.Connection.open_from_string (
            "SQLite",
            @"DB_DIR=$(database_directory);DB_NAME=$(DATABASE_FILENAME)",
            null,
            Gda.ConnectionOptions.NONE
        );

        if (!database_file.query_exists ()) {
            print ("Creating Database…\n");

            print ("Creating table 'template'\n");
            this.connection.execute_non_select_command ("DROP TABLE IF EXISTS template");
            this.connection.execute_non_select_command ("CREATE TABLE template (id INTEGER PRIMARY KEY, name TEXT, content TEXT)");
            this.connection.execute_non_select_command ("INSERT INTO template (name, content) VALUES (\"Demo Template\", \"My name is: {{name}}\")");
            this.connection.update_meta_store (null);
        } else {
            print ("Database Exists\n");
        }

    }
}