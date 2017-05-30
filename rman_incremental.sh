rman target / LOG=/bkp/LOG_ARCH_$DATA.log <<EOF
CONFIGURE BACKUP OPTIMIZATION ON;
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE RETENTION POLICY TO RECOVERY WINDOW OF &1 DAYS;
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '&2/%F_CONTROL_FILE';
RUN
{
ALLOCATE CHANNEL ch1 TYPE DISK;
ALLOCATE CHANNEL ch2 TYPE DISK;
ALLOCATE CHANNEL ch3 TYPE DISK;

SHUTDOWN IMMEDIATE;
STARTUP MOUNT;

BACKUP AS BACKUPSET
       INCREMENTAL LEVEL  $nivel
       DATABASE
       FORMAT '$caminho'
       TAG '$tag'
       KEEP UNTIL TIME "to_date('$data','dd/mm/yyyy')";	
ALTER DATABASE OPEN;
}
EOF