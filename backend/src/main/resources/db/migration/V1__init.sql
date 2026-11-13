-- V1: initial schema, generated from the JPA entities in com.gitfit.backend.entity
create table users (
    id bigint not null auto_increment,
    username varchar(255) not null,
    email varchar(255) not null,
    password_hash varchar(255) not null,
    role varchar(255) not null,
    account_status varchar(255) not null,
    goals varchar(255),
    training_experience varchar(255),
    body_weight float(53),
    height float(53),
    age integer,
    weekly_workout_target integer,
    created_at datetime(6) not null,
    updated_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

create table muscle_group (
    id bigint not null auto_increment,
    name varchar(255) not null,
    primary key (id)
) engine=InnoDB;

create table exercise (
    id bigint not null auto_increment,
    name varchar(255) not null,
    equipment varchar(255),
    tracking_type varchar(255) not null,
    custom bit not null,
    created_by_id bigint,
    created_at datetime(6) not null,
    updated_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

create table exercise_muscle_group (
    id bigint not null auto_increment,
    exercise_id bigint not null,
    muscle_group_id bigint not null,
    primary key (id)
) engine=InnoDB;

create table workout_split (
    id bigint not null auto_increment,
    owner_id bigint not null,
    name varchar(255) not null,
    visibility varchar(255) not null,
    created_at datetime(6) not null,
    updated_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

create table split_day (
    id bigint not null auto_increment,
    split_id bigint not null,
    name varchar(255) not null,
    position integer not null,
    primary key (id)
) engine=InnoDB;

create table split_day_exercise (
    id bigint not null auto_increment,
    split_day_id bigint not null,
    exercise_id bigint not null,
    position integer not null,
    planned_sets integer,
    planned_reps integer,
    target_weight float(53),
    primary key (id)
) engine=InnoDB;

create table workout (
    id bigint not null auto_increment,
    owner_id bigint not null,
    name varchar(255),
    workout_date date not null,
    duration_seconds integer,
    activity_type varchar(255),
    notes varchar(255),
    visibility varchar(255) not null,
    created_at datetime(6) not null,
    updated_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

create table workout_exercise (
    id bigint not null auto_increment,
    workout_id bigint not null,
    exercise_id bigint not null,
    position integer not null,
    primary key (id)
) engine=InnoDB;

create table workout_set (
    id bigint not null auto_increment,
    workout_exercise_id bigint not null,
    position integer not null,
    set_type varchar(255) not null,
    reps integer,
    weight float(53),
    duration_seconds integer,
    distance float(53),
    completed bit not null,
    primary key (id)
) engine=InnoDB;

create table friendship (
    id bigint not null auto_increment,
    requester_id bigint not null,
    addressee_id bigint not null,
    status varchar(255) not null,
    created_at datetime(6) not null,
    updated_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

create table challenge (
    id bigint not null auto_increment,
    name varchar(255) not null,
    start_date date not null,
    end_date date not null,
    eligible_activities varchar(255),
    scoring_rules varchar(255),
    goal_points integer,
    created_at datetime(6) not null,
    updated_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

create table challenge_entry (
    id bigint not null auto_increment,
    challenge_id bigint not null,
    user_id bigint not null,
    created_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

create table post (
    id bigint not null auto_increment,
    author_id bigint not null,
    workout_id bigint,
    split_id bigint,
    caption varchar(255),
    visibility varchar(255) not null,
    created_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

create table comment (
    id bigint not null auto_increment,
    post_id bigint not null,
    author_id bigint not null,
    content varchar(255) not null,
    created_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

create table reaction (
    id bigint not null auto_increment,
    post_id bigint not null,
    user_id bigint not null,
    created_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

create table report (
    id bigint not null auto_increment,
    reporter_id bigint not null,
    post_id bigint,
    comment_id bigint,
    challenge_entry_id bigint,
    reason varchar(255),
    created_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

create table moderation_action (
    id bigint not null auto_increment,
    admin_id bigint not null,
    report_id bigint,
    target_user_id bigint,
    reason varchar(255) not null,
    created_at datetime(6) not null,
    primary key (id)
) engine=InnoDB;

alter table exercise add constraint fk_exercise_created_by foreign key (created_by_id) references users (id);
alter table exercise_muscle_group add constraint fk_exercise_muscle_group_exercise foreign key (exercise_id) references exercise (id);
alter table exercise_muscle_group add constraint fk_exercise_muscle_group_muscle_group foreign key (muscle_group_id) references muscle_group (id);
alter table workout_split add constraint fk_workout_split_owner foreign key (owner_id) references users (id);
alter table split_day add constraint fk_split_day_split foreign key (split_id) references workout_split (id);
alter table split_day_exercise add constraint fk_split_day_exercise_split_day foreign key (split_day_id) references split_day (id);
alter table split_day_exercise add constraint fk_split_day_exercise_exercise foreign key (exercise_id) references exercise (id);
alter table workout add constraint fk_workout_owner foreign key (owner_id) references users (id);
alter table workout_exercise add constraint fk_workout_exercise_workout foreign key (workout_id) references workout (id);
alter table workout_exercise add constraint fk_workout_exercise_exercise foreign key (exercise_id) references exercise (id);
alter table workout_set add constraint fk_workout_set_workout_exercise foreign key (workout_exercise_id) references workout_exercise (id);
alter table friendship add constraint fk_friendship_requester foreign key (requester_id) references users (id);
alter table friendship add constraint fk_friendship_addressee foreign key (addressee_id) references users (id);
alter table challenge_entry add constraint fk_challenge_entry_challenge foreign key (challenge_id) references challenge (id);
alter table challenge_entry add constraint fk_challenge_entry_user foreign key (user_id) references users (id);
alter table post add constraint fk_post_author foreign key (author_id) references users (id);
alter table post add constraint fk_post_workout foreign key (workout_id) references workout (id);
alter table post add constraint fk_post_split foreign key (split_id) references workout_split (id);
alter table comment add constraint fk_comment_post foreign key (post_id) references post (id);
alter table comment add constraint fk_comment_author foreign key (author_id) references users (id);
alter table reaction add constraint fk_reaction_post foreign key (post_id) references post (id);
alter table reaction add constraint fk_reaction_user foreign key (user_id) references users (id);
alter table report add constraint fk_report_reporter foreign key (reporter_id) references users (id);
alter table report add constraint fk_report_post foreign key (post_id) references post (id);
alter table report add constraint fk_report_comment foreign key (comment_id) references comment (id);
alter table report add constraint fk_report_challenge_entry foreign key (challenge_entry_id) references challenge_entry (id);
alter table moderation_action add constraint fk_moderation_action_admin foreign key (admin_id) references users (id);
alter table moderation_action add constraint fk_moderation_action_report foreign key (report_id) references report (id);
alter table moderation_action add constraint fk_moderation_action_target_user foreign key (target_user_id) references users (id);
