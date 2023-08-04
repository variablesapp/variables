public class Variables.Template: GLib.Object {
    /**
    * The name of the template
    */
    public string name { get; set; }

    /**
    * Used to subsitiute template values
    */
    public Gee.ArrayList<Variables.Variable> variables { get; set; }

    /**
    * The text content of the template
    **/
    public string content { get; set; }

    public int id { get; construct; }
}