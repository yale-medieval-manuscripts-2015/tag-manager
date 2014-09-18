class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps
    end

    add_index :users, :provider,             unique: false
    add_index :users, :uid,                  unique: true
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  endCREATE TABLE "users" (
    `Field1`	INTEGER,
    `provider`	varchar(255),
        `uid`	varchar(255),
        `name`	varchar(255),
        `email`	varchar(255) NOT NULL DEFAULT '''',
                                               `encrypted_password`	varchar(255) NOT NULL DEFAULT '''',
                                                                                                   `reset_password_token`	varchar(255),
        `reset_password_sent_at`	datetime,
    `remember_created_at`	datetime,
    `sign_in_count`	integer NOT NULL DEFAULT '0',
                                              `current_sign_in_at`	datetime,
    `last_sign_in_at`	datetime,
    `current_sign_in_ip`	varchar(255),
        `last_sign_in_ip`	varchar(255),
        PRIMARY KEY(provider)
    );
    INSERT INTO `users` VALUES('','cas','rl95','','','','','','','1','2014-09-16 03:05:44.469025','2014-09-16 03:05:44.469025','127.0.0.1','127.0.0.1');
    INSERT INTO `users` VALUES('','cas1','rl96','Ed',''',''','','','','0','','','','');
    INSERT INTO `users` VALUES('','cas2','rl97','Bob',''',''','','','','0','','','','');
    INSERT INTO `users` VALUES('','cas3','rl98','Joe',''',''','','','','0','','','','');

  end
