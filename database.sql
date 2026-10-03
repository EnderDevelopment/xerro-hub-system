CREATE TABLE IF NOT EXISTS xerro_hub_settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    player_id INT NOT NULL,
    ui_color VARCHAR(255) NOT NULL,
    ui_text VARCHAR(255) NOT NULL,
    ui_position VARCHAR(255) NOT NULL,
    ui_size VARCHAR(255) NOT NULL,
    fly_speed FLOAT NOT NULL,
    noclip_speed FLOAT NOT NULL,
    UNIQUE KEY unique_player (player_id)
);

INSERT INTO xerro_hub_settings (player_id, ui_color, ui_text, ui_position, ui_size, fly_speed, noclip_speed) VALUES
(1, '{"r": 0, "g": 0, "b": 255, "a": 200}', 'Xerro Hub', '{"x": 0.85, "y": 0.1}', '{"width": 0.15, "height": 0.2}', 1.0, 1.0);