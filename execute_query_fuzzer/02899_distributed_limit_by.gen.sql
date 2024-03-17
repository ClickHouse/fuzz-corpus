


select 'Used settings: prefer_localhost_replica=0,distributed_group_by_no_merge=0,distributed_push_down_limit=1';
select dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by dummy + dummy + 0 as l settings prefer_localhost_replica=0,distributed_group_by_no_merge=0,distributed_push_down_limit=1;
select dummy from (select dummy + dummy + 0 as l, dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by l) settings prefer_localhost_replica=0,distributed_group_by_no_merge=0,distributed_push_down_limit=1;


select 'Used settings: prefer_localhost_replica=0,distributed_group_by_no_merge=0,distributed_push_down_limit=0';
select dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by dummy + dummy + 0 as l settings prefer_localhost_replica=0,distributed_group_by_no_merge=0,distributed_push_down_limit=0;
select dummy from (select dummy + dummy + 0 as l, dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by l) settings prefer_localhost_replica=0,distributed_group_by_no_merge=0,distributed_push_down_limit=0;


select 'Used settings: prefer_localhost_replica=0,distributed_group_by_no_merge=1,distributed_push_down_limit=1';
select dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by dummy + dummy + 0 as l settings prefer_localhost_replica=0,distributed_group_by_no_merge=1,distributed_push_down_limit=1;
select dummy from (select dummy + dummy + 0 as l, dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by l) settings prefer_localhost_replica=0,distributed_group_by_no_merge=1,distributed_push_down_limit=1;


select 'Used settings: prefer_localhost_replica=0,distributed_group_by_no_merge=1,distributed_push_down_limit=0';
select dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by dummy + dummy + 0 as l settings prefer_localhost_replica=0,distributed_group_by_no_merge=1,distributed_push_down_limit=0;
select dummy from (select dummy + dummy + 0 as l, dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by l) settings prefer_localhost_replica=0,distributed_group_by_no_merge=1,distributed_push_down_limit=0;


select 'Used settings: prefer_localhost_replica=0,distributed_group_by_no_merge=2,distributed_push_down_limit=1';
select dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by dummy + dummy + 0 as l settings prefer_localhost_replica=0,distributed_group_by_no_merge=2,distributed_push_down_limit=1;
select dummy from (select dummy + dummy + 0 as l, dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by l) settings prefer_localhost_replica=0,distributed_group_by_no_merge=2,distributed_push_down_limit=1;


select 'Used settings: prefer_localhost_replica=0,distributed_group_by_no_merge=2,distributed_push_down_limit=0';
select dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by dummy + dummy + 0 as l settings prefer_localhost_replica=0,distributed_group_by_no_merge=2,distributed_push_down_limit=0;
select dummy from (select dummy + dummy + 0 as l, dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by l) settings prefer_localhost_replica=0,distributed_group_by_no_merge=2,distributed_push_down_limit=0;


select 'Used settings: prefer_localhost_replica=1,distributed_group_by_no_merge=0,distributed_push_down_limit=1';
select dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by dummy + dummy + 0 as l settings prefer_localhost_replica=1,distributed_group_by_no_merge=0,distributed_push_down_limit=1;
select dummy from (select dummy + dummy + 0 as l, dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by l) settings prefer_localhost_replica=1,distributed_group_by_no_merge=0,distributed_push_down_limit=1;


select 'Used settings: prefer_localhost_replica=1,distributed_group_by_no_merge=0,distributed_push_down_limit=0';
select dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by dummy + dummy + 0 as l settings prefer_localhost_replica=1,distributed_group_by_no_merge=0,distributed_push_down_limit=0;
select dummy from (select dummy + dummy + 0 as l, dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by l) settings prefer_localhost_replica=1,distributed_group_by_no_merge=0,distributed_push_down_limit=0;


select 'Used settings: prefer_localhost_replica=1,distributed_group_by_no_merge=1,distributed_push_down_limit=1';
select dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by dummy + dummy + 0 as l settings prefer_localhost_replica=1,distributed_group_by_no_merge=1,distributed_push_down_limit=1;
select dummy from (select dummy + dummy + 0 as l, dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by l) settings prefer_localhost_replica=1,distributed_group_by_no_merge=1,distributed_push_down_limit=1;


select 'Used settings: prefer_localhost_replica=1,distributed_group_by_no_merge=1,distributed_push_down_limit=0';
select dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by dummy + dummy + 0 as l settings prefer_localhost_replica=1,distributed_group_by_no_merge=1,distributed_push_down_limit=0;
select dummy from (select dummy + dummy + 0 as l, dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by l) settings prefer_localhost_replica=1,distributed_group_by_no_merge=1,distributed_push_down_limit=0;


select 'Used settings: prefer_localhost_replica=1,distributed_group_by_no_merge=2,distributed_push_down_limit=1';
select dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by dummy + dummy + 0 as l settings prefer_localhost_replica=1,distributed_group_by_no_merge=2,distributed_push_down_limit=1;
select dummy from (select dummy + dummy + 0 as l, dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by l) settings prefer_localhost_replica=1,distributed_group_by_no_merge=2,distributed_push_down_limit=1;


select 'Used settings: prefer_localhost_replica=1,distributed_group_by_no_merge=2,distributed_push_down_limit=0';
select dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by dummy + dummy + 0 as l settings prefer_localhost_replica=1,distributed_group_by_no_merge=2,distributed_push_down_limit=0;
select dummy from (select dummy + dummy + 0 as l, dummy from remote('127.{1,1}', system.one) where dummy + dummy >= 0 limit 1 by l) settings prefer_localhost_replica=1,distributed_group_by_no_merge=2,distributed_push_down_limit=0;

