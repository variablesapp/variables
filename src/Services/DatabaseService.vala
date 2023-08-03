/* Copyright 2016 Software Freedom Conservancy Inc.
 *
 * This software is licensed under the GNU Lesser General Public License
 * (version 2.1 or later).  See the COPYING file in this distribution.
**/

namespace Variables.DatabaseService {
    public const string IN_MEMORY_NAME = ":memory:";

    private string? filename = null;

    // Passing null as the db_file will create an in-memory, non-persistent database.
    public void preconfigure (File? db_file) {
        filename = (db_file != null) ? db_file.get_path () : IN_MEMORY_NAME;
    }

    public void init () throws Error {
        assert (filename != null);
    }

}