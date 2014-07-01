# Adds the contents menu. Inside the contents sub menu we ensure it's needed
Deface::Override.new(:virtual_path  => "spree/admin/shared/_menu",
                     :name          => "spree_essential_contents_menu",
                     :insert_after  => "#admin-menu[data-hook]",
                     :partial       => "spree/admin/shared/contents_sub_menu",
                     :disabled      => false)
