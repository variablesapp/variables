public class Variables.VariablesView : Gtk.Box {
    public Variables.VariablesViewModel view_model { get; construct; }
    public Variables.MainWindow window { get; construct; }

    public VariablesView (Variables.MainWindow window) {
        Object (window: window);
    }

    construct {
        this.hexpand = true;
        this.orientation = Gtk.Orientation.VERTICAL;
        view_model = (Variables.VariablesViewModel) window.container.get (typeof(Variables.VariablesViewModel));        
        //  var list_view = new Gtk.ListView (owned Gtk.SelectionModel? model, owned Gtk.ListItemFactory? factory)
        this.append (new Gtk.Label ("Hey world!"));
    }
}