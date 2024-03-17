-- { echo }

select '-- no-tld';
-- even if there is no TLD, 2-nd level by default anyway
-- FIXME: make this behavior optional (so that TLD for host never changed, either empty or something real)
select cutToFirstSignificantSubdomain('there-is-no-such-domain');
select cutToFirstSignificantSubdomain('foo.there-is-no-such-domain');
select cutToFirstSignificantSubdomain('bar.foo.there-is-no-such-domain');
select cutToFirstSignificantSubdomainCustom('there-is-no-such-domain', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustom('foo.there-is-no-such-domain', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustom('bar.foo.there-is-no-such-domain', 'public_suffix_list');
select firstSignificantSubdomainCustom('bar.foo.there-is-no-such-domain', 'public_suffix_list');

select '-- generic';
select firstSignificantSubdomainCustom('foo.kernel.biz.ss', 'public_suffix_list'); -- kernel
select cutToFirstSignificantSubdomainCustom('foo.kernel.biz.ss', 'public_suffix_list'); -- kernel.biz.ss

select '-- difference';
-- dev.ss is not in the default TLD list, hence:
select cutToFirstSignificantSubdomain('foo.kernel.dev.ss'); -- dev.ss
select cutToFirstSignificantSubdomainCustom('foo.kernel.dev.ss', 'public_suffix_list'); -- kernel.dev.ss

select '-- 3+level';
select cutToFirstSignificantSubdomainCustom('xx.blogspot.co.at', 'public_suffix_list'); -- xx.blogspot.co.at
select firstSignificantSubdomainCustom('xx.blogspot.co.at', 'public_suffix_list'); -- blogspot
select cutToFirstSignificantSubdomainCustom('foo.bar.xx.blogspot.co.at', 'public_suffix_list'); -- xx.blogspot.co.at
select firstSignificantSubdomainCustom('foo.bar.xx.blogspot.co.at', 'public_suffix_list'); -- blogspot

select '-- url';
select cutToFirstSignificantSubdomainCustom('http://foobar.com', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustom('http://foobar.com/foo', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustom('http://bar.foobar.com/foo', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustom('http://xx.blogspot.co.at', 'public_suffix_list');

select '-- www';
select cutToFirstSignificantSubdomainCustomWithWWW('http://www.foo', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustom('http://www.foo', 'public_suffix_list');

select '-- vector';
select cutToFirstSignificantSubdomainCustom('http://xx.blogspot.co.at/' || toString(number), 'public_suffix_list') from numbers(1);
select cutToFirstSignificantSubdomainCustom('there-is-no-such-domain' || toString(number), 'public_suffix_list') from numbers(1);

select '-- no new line';
select cutToFirstSignificantSubdomainCustom('foo.bar', 'no_new_line_list');
select cutToFirstSignificantSubdomainCustom('a.foo.bar', 'no_new_line_list');
select cutToFirstSignificantSubdomainCustom('a.foo.baz', 'no_new_line_list');

select '-- asterisk';
select cutToFirstSignificantSubdomainCustom('foo.something.sheffield.sch.uk', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustom('something.sheffield.sch.uk', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustom('sheffield.sch.uk', 'public_suffix_list');

select '-- exclamation mark';
select cutToFirstSignificantSubdomainCustom('foo.kawasaki.jp', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustom('foo.foo.kawasaki.jp', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustom('city.kawasaki.jp', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustom('some.city.kawasaki.jp', 'public_suffix_list');

select '-- no-tld';
-- even if there is no TLD, 2-nd level by default anyway
-- FIXME: make this behavior optional (so that TLD for host never changed, either empty or something real)
select cutToFirstSignificantSubdomainRFC('there-is-no-such-domain');
select cutToFirstSignificantSubdomainRFC('foo.there-is-no-such-domain');
select cutToFirstSignificantSubdomainRFC('bar.foo.there-is-no-such-domain');
select cutToFirstSignificantSubdomainCustomRFC('there-is-no-such-domain', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustomRFC('foo.there-is-no-such-domain', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustomRFC('bar.foo.there-is-no-such-domain', 'public_suffix_list');
select firstSignificantSubdomainCustomRFC('bar.foo.there-is-no-such-domain', 'public_suffix_list');

select '-- generic';
select firstSignificantSubdomainCustomRFC('foo.kernel.biz.ss', 'public_suffix_list'); -- kernel
select cutToFirstSignificantSubdomainCustomRFC('foo.kernel.biz.ss', 'public_suffix_list'); -- kernel.biz.ss

select '-- difference';
-- dev.ss is not in the default TLD list, hence:
select cutToFirstSignificantSubdomainRFC('foo.kernel.dev.ss'); -- dev.ss
select cutToFirstSignificantSubdomainCustomRFC('foo.kernel.dev.ss', 'public_suffix_list'); -- kernel.dev.ss

select '-- 3+level';
select cutToFirstSignificantSubdomainCustomRFC('xx.blogspot.co.at', 'public_suffix_list'); -- xx.blogspot.co.at
select firstSignificantSubdomainCustomRFC('xx.blogspot.co.at', 'public_suffix_list'); -- blogspot
select cutToFirstSignificantSubdomainCustomRFC('foo.bar.xx.blogspot.co.at', 'public_suffix_list'); -- xx.blogspot.co.at
select firstSignificantSubdomainCustomRFC('foo.bar.xx.blogspot.co.at', 'public_suffix_list'); -- blogspot

select '-- url';
select cutToFirstSignificantSubdomainCustomRFC('http://foobar.com', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustomRFC('http://foobar.com/foo', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustomRFC('http://bar.foobar.com/foo', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustomRFC('http://xx.blogspot.co.at', 'public_suffix_list');

select '-- www';
select cutToFirstSignificantSubdomainCustomWithWWWRFC('http://www.foo', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustomRFC('http://www.foo', 'public_suffix_list');

select '-- vector';
select cutToFirstSignificantSubdomainCustomRFC('http://xx.blogspot.co.at/' || toString(number), 'public_suffix_list') from numbers(1);
select cutToFirstSignificantSubdomainCustomRFC('there-is-no-such-domain' || toString(number), 'public_suffix_list') from numbers(1);

select '-- no new line';
select cutToFirstSignificantSubdomainCustomRFC('foo.bar', 'no_new_line_list');
select cutToFirstSignificantSubdomainCustomRFC('a.foo.bar', 'no_new_line_list');
select cutToFirstSignificantSubdomainCustomRFC('a.foo.baz', 'no_new_line_list');

select '-- asterisk';
select cutToFirstSignificantSubdomainCustomRFC('foo.something.sheffield.sch.uk', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustomRFC('something.sheffield.sch.uk', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustomRFC('sheffield.sch.uk', 'public_suffix_list');

select '-- exclamation mark';
select cutToFirstSignificantSubdomainCustomRFC('foo.kawasaki.jp', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustomRFC('foo.foo.kawasaki.jp', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustomRFC('city.kawasaki.jp', 'public_suffix_list');
select cutToFirstSignificantSubdomainCustomRFC('some.city.kawasaki.jp', 'public_suffix_list');


