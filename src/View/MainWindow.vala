public class Variables.MainWindow : Gtk.ApplicationWindow {
    public Variables.MainViewModel view_model { get; construct set; }

    public MainWindow (Gtk.Application app) {
        Object (
            application: app
        );
    }

    static construct {
        var css_provider = new Gtk.CssProvider ();
        css_provider.load_from_resource (Constants.APP_PATH + "style.css");

        Gtk.StyleContext.add_provider_for_display (Gdk.Display.get_default (),
            css_provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );
    }

    construct {
        this.set_size_request (640, 480);

        var container = Application.container ();
        this.view_model = new MainViewModel (container);

        var header_bar = new Gtk.HeaderBar ();
        this.set_titlebar (header_bar);

        var start_paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);
        var end_paned = new Gtk.Paned (Gtk.Orientation.HORIZONTAL);

        start_paned.position = 180;

        end_paned.position = 250;

        start_paned.set_start_child (new Variables.TemplatesView ());
        start_paned.set_end_child (end_paned);

        end_paned.set_start_child (new Variables.VariablesView ());
        end_paned.set_end_child (new Variables.TemplateEditorView ());

        this.set_child (start_paned);
    }
}
