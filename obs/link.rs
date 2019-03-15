use std::env;
use std::fs;

fn main() {
    let config_dir = dirs::config_dir().expect("Failed to obtain config dir.");
    let old_settings_dir = config_dir.join("obs-studio");
    let settings_backup_dir = config_dir.join("obs-studio-backup");
    let new_settings_dir = fs::canonicalize(env::current_dir().unwrap())
        .unwrap()
        .join("unix");

    let link = || {
        // TODO: Not very cross platform eh?
        match std::os::unix::fs::symlink(&new_settings_dir, &old_settings_dir) {
            Ok(()) => println!(
                "Created symlink at {:?} pointing to {:?}",
                &old_settings_dir.display(),
                &new_settings_dir.display()
            ),
            Err(error) => panic!(
                "Failed to create symlink from {:?} to {:?}: {}",
                &old_settings_dir.display(),
                &new_settings_dir.display(),
                error
            ),
        }
    };

    let unlink = || match fs::remove_file(&old_settings_dir) {
        Ok(()) => println!("Removed old symlink at {:?}", old_settings_dir.display()),
        Err(error) => panic!(
            "Failed to remove old symlink at {:?}: {}",
            old_settings_dir.display(),
            error,
        ),
    };

    let backup = || {
        // See if backup dir exists.
        if let Ok(meta) = fs::symlink_metadata(&settings_backup_dir) {
            panic!(
                "Cannot backup to {:?} because a {:?} exists at its location!",
                settings_backup_dir.display(),
                meta.file_type()
            );
        }
        // Attempt to rename.
        match fs::rename(&old_settings_dir, &settings_backup_dir) {
            Ok(()) => println!(
                "Renamed {:?} to {:?}.",
                old_settings_dir.display(),
                settings_backup_dir.display()
            ),
            Err(error) => panic!(
                "Failed to rename {:?} to {:?}: {}.",
                &old_settings_dir.display(),
                settings_backup_dir.display(),
                error
            ),
        }
    };

    match fs::symlink_metadata(&old_settings_dir) {
        Ok(meta) => {
            let file_type = meta.file_type();
            if file_type.is_symlink() {
                unlink();
                link();
            } else if file_type.is_dir() {
                backup();
                link();
            } else {
                panic!(
                    "{:?} has unexpected file type {:?}.",
                    old_settings_dir.display(),
                    file_type
                );
            }
        }
        Err(error) => match error.kind() {
            std::io::ErrorKind::NotFound => link(),
            _ => panic!(
                "Failed to query metadata for {:?}: {}",
                old_settings_dir, error
            ),
        },
    }
}
