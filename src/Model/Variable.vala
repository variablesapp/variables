public class Variables.Variable: GLib.Object {
    /**
    * Name of variable
    * 
    * Name used in template variable substitution
    */
    public string name { get; set construct; }

    /**
    * Value of variable
    *
    * The string that the variable name will be substituted for 
    *
    * @see Variables.Variable.name
    */
    public string value { get; set construct; }

    public int id { get; construct; }
}