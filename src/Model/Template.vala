public class Variables.Template: GLib.Object {
    /**
    * The name of the template
    */
    public string name { get; set; }

    /**
    * Used to subsitiute template values
    */
    public GLib.HashTable<string, string> variables { get; set; }

    /**
    * The text content of the template
    **/
    public string content { get; set; }
}