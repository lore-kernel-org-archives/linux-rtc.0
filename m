Return-Path: <rtc-linux+bncBDJ4N37Q6EERBQHNY7CAKGQEFZWDUMQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mga06.intel.com (mga06.intel.com. [134.134.136.31])
        by gmr-mx.google.com with ESMTPS id 23si4188158pfw.4.2017.02.01.06.54.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2017 06:54:55 -0800 (PST)
Date: Wed, 1 Feb 2017 22:54:04 +0800
From: kbuild test robot <lkp@intel.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: kbuild-all@01.org, Alessandro Zummo <a.zummo@towertech.it>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Arnd Bergmann <arnd@arndb.de>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [rtc-linux] Re: [PATCH] rtc: sun6i: extend test coverage
Message-ID: <201702012213.km9Mzmee%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
In-Reply-To: <20170201115706.3750-1-alexandre.belloni@free-electrons.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Alexandre,

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on next-20170201]
[cannot apply to v4.10-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexandre-Belloni/rtc-sun6i-extend-test-coverage/20170201-200542
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All error/warnings (new ones prefixed by >>):

>> drivers/clocksource/timer-sun5i.c:52:21: error: field 'clksrc' has incomplete type
     struct clocksource clksrc;
                        ^~~~~~
>> drivers/clocksource/timer-sun5i.c:60:28: error: field 'clkevt' has incomplete type
     struct clock_event_device clkevt;
                               ^~~~~~
   In file included from include/linux/clk.h:16:0,
                    from drivers/clocksource/timer-sun5i.c:13:
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clkevt_shutdown':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:108:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:850:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:108:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clkevt_set_oneshot':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:116:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:850:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:116:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clkevt_set_periodic':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:125:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:850:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:125:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clkevt_next_event':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:136:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:850:48: note: (near initialization for 'ce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/clocksource/timer-sun5i.c:64:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clkevt, clkevt)
     ^~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:136:34: note: in expansion of macro 'to_sun5i_timer_clkevt'
     struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_clksrc_read':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:56:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clksrc, clksrc)
     ^~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:157:34: note: in expansion of macro 'to_sun5i_timer_clksrc'
     struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
                                     ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:850:48: note: (near initialization for 'cs')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/timer-sun5i.c:56:2: note: in expansion of macro 'container_of'
     container_of(x, struct sun5i_timer_clksrc, clksrc)
     ^~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:157:34: note: in expansion of macro 'to_sun5i_timer_clksrc'
     struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
                                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_rate_cb_clksrc':
>> drivers/clocksource/timer-sun5i.c:171:3: error: implicit declaration of function 'clocksource_unregister' [-Werror=implicit-function-declaration]
      clocksource_unregister(&cs->clksrc);
      ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:175:3: error: implicit declaration of function 'clocksource_register_hz' [-Werror=implicit-function-declaration]
      clocksource_register_hz(&cs->clksrc, ndata->new_rate);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_setup_clocksource':
>> drivers/clocksource/timer-sun5i.c:223:20: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]
     cs->clksrc.mask = CLOCKSOURCE_MASK(32);
                       ^~~~~~~~~~~~~~~~
>> drivers/clocksource/timer-sun5i.c:224:21: error: 'CLOCK_SOURCE_IS_CONTINUOUS' undeclared (first use in this function)
     cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c:224:21: note: each undeclared identifier is reported only once for each function it appears in
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_rate_cb_clkevt':
>> drivers/clocksource/timer-sun5i.c:251:3: error: implicit declaration of function 'clockevents_update_freq' [-Werror=implicit-function-declaration]
      clockevents_update_freq(&ce->clkevt, ndata->new_rate);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/timer-sun5i.c: In function 'sun5i_setup_clockevent':
>> drivers/clocksource/timer-sun5i.c:291:24: error: 'CLOCK_EVT_FEAT_PERIODIC' undeclared (first use in this function)
     ce->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                           ^~~~~~~~~~~~~~~~~~~~~~~
--
>> drivers/clocksource/cadence_ttc_timer.c:92:21: error: field 'cs' has incomplete type
     struct clocksource cs;
                        ^~
>> drivers/clocksource/cadence_ttc_timer.c:100:28: error: field 'ce' has incomplete type
     struct clock_event_device ce;
                               ^~
   In file included from include/linux/clk.h:16:0,
                    from drivers/clocksource/cadence_ttc_timer.c:18:
   drivers/clocksource/cadence_ttc_timer.c: In function '__ttc_clocksource_read':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/clocksource/cadence_ttc_timer.c:96:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clocksource, cs)
      ^~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:163:29: note: in expansion of macro 'to_ttc_timer_clksrc'
     struct ttc_timer *timer = &to_ttc_timer_clksrc(cs)->ttc;
                                ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:850:48: note: (near initialization for 'timer')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
>> drivers/clocksource/cadence_ttc_timer.c:96:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clocksource, cs)
      ^~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:163:29: note: in expansion of macro 'to_ttc_timer_clksrc'
     struct ttc_timer *timer = &to_ttc_timer_clksrc(cs)->ttc;
                                ^~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_set_next_event':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:185:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:850:48: note: (near initialization for 'ttce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:185:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_shutdown':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:199:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:850:48: note: (near initialization for 'ttce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:199:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_set_periodic':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:211:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:850:48: note: (near initialization for 'ttce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:211:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_resume':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:221:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:850:48: note: (near initialization for 'ttce')
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   drivers/clocksource/cadence_ttc_timer.c:104:3: note: in expansion of macro 'container_of'
      container_of(x, struct ttc_timer_clockevent, ce)
      ^~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:221:38: note: in expansion of macro 'to_ttc_timer_clkevent'
     struct ttc_timer_clockevent *ttce = to_ttc_timer_clkevent(evt);
                                         ^~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_setup_clocksource':
>> drivers/clocksource/cadence_ttc_timer.c:358:19: error: implicit declaration of function 'CLOCKSOURCE_MASK' [-Werror=implicit-function-declaration]
     ttccs->cs.mask = CLOCKSOURCE_MASK(timer_width);
                      ^~~~~~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:359:20: error: 'CLOCK_SOURCE_IS_CONTINUOUS' undeclared (first use in this function)
     ttccs->cs.flags = CLOCK_SOURCE_IS_CONTINUOUS;
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:359:20: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/clocksource/cadence_ttc_timer.c:372:8: error: implicit declaration of function 'clocksource_register_hz' [-Werror=implicit-function-declaration]
     err = clocksource_register_hz(&ttccs->cs, ttccs->ttc.freq / PRESCALE);
           ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_rate_change_clockevent_cb':
>> drivers/clocksource/cadence_ttc_timer.c:398:3: error: implicit declaration of function 'clockevents_update_freq' [-Werror=implicit-function-declaration]
      clockevents_update_freq(&ttcce->ce, ndata->new_rate / PRESCALE);
      ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: In function 'ttc_setup_clockevent':
>> drivers/clocksource/cadence_ttc_timer.c:441:23: error: 'CLOCK_EVT_FEAT_PERIODIC' undeclared (first use in this function)
     ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                          ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:441:49: error: 'CLOCK_EVT_FEAT_ONESHOT' undeclared (first use in this function)
     ttcce->ce.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
                                                    ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/clocksource/cadence_ttc_timer.c:468:2: error: implicit declaration of function 'clockevents_config_and_register' [-Werror=implicit-function-declaration]
     clockevents_config_and_register(&ttcce->ce,
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c: At top level:
>> drivers/clocksource/cadence_ttc_timer.c:542:29: error: expected ')' before string constant
    CLOCKSOURCE_OF_DECLARE(ttc, "cdns,ttc", ttc_timer_init);
                                ^~~~~~~~~~
   drivers/clocksource/cadence_ttc_timer.c:480:19: warning: 'ttc_timer_init' defined but not used [-Wunused-function]
    static int __init ttc_timer_init(struct device_node *timer)
                      ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/clksrc +52 drivers/clocksource/timer-sun5i.c

67905540 Maxime Ripard   2013-11-07    7   *
67905540 Maxime Ripard   2013-11-07    8   * This file is licensed under the terms of the GNU General Public
67905540 Maxime Ripard   2013-11-07    9   * License version 2.  This program is licensed "as is" without any
67905540 Maxime Ripard   2013-11-07   10   * warranty of any kind, whether express or implied.
67905540 Maxime Ripard   2013-11-07   11   */
67905540 Maxime Ripard   2013-11-07   12  
67905540 Maxime Ripard   2013-11-07  @13  #include <linux/clk.h>
67905540 Maxime Ripard   2013-11-07   14  #include <linux/clockchips.h>
67905540 Maxime Ripard   2013-11-07   15  #include <linux/delay.h>
67905540 Maxime Ripard   2013-11-07   16  #include <linux/interrupt.h>
67905540 Maxime Ripard   2013-11-07   17  #include <linux/irq.h>
67905540 Maxime Ripard   2013-11-07   18  #include <linux/irqreturn.h>
e50a00be Maxime Ripard   2014-04-17   19  #include <linux/reset.h>
4a59058f Maxime Ripard   2015-03-31   20  #include <linux/slab.h>
67905540 Maxime Ripard   2013-11-07   21  #include <linux/of.h>
67905540 Maxime Ripard   2013-11-07   22  #include <linux/of_address.h>
67905540 Maxime Ripard   2013-11-07   23  #include <linux/of_irq.h>
67905540 Maxime Ripard   2013-11-07   24  
67905540 Maxime Ripard   2013-11-07   25  #define TIMER_IRQ_EN_REG		0x00
67905540 Maxime Ripard   2013-11-07   26  #define TIMER_IRQ_EN(val)			BIT(val)
67905540 Maxime Ripard   2013-11-07   27  #define TIMER_IRQ_ST_REG		0x04
67905540 Maxime Ripard   2013-11-07   28  #define TIMER_CTL_REG(val)		(0x20 * (val) + 0x10)
67905540 Maxime Ripard   2013-11-07   29  #define TIMER_CTL_ENABLE			BIT(0)
67905540 Maxime Ripard   2013-11-07   30  #define TIMER_CTL_RELOAD			BIT(1)
67905540 Maxime Ripard   2013-11-07   31  #define TIMER_CTL_CLK_PRES(val)			(((val) & 0x7) << 4)
67905540 Maxime Ripard   2013-11-07   32  #define TIMER_CTL_ONESHOT			BIT(7)
67905540 Maxime Ripard   2013-11-07   33  #define TIMER_INTVAL_LO_REG(val)	(0x20 * (val) + 0x14)
67905540 Maxime Ripard   2013-11-07   34  #define TIMER_INTVAL_HI_REG(val)	(0x20 * (val) + 0x18)
67905540 Maxime Ripard   2013-11-07   35  #define TIMER_CNTVAL_LO_REG(val)	(0x20 * (val) + 0x1c)
67905540 Maxime Ripard   2013-11-07   36  #define TIMER_CNTVAL_HI_REG(val)	(0x20 * (val) + 0x20)
67905540 Maxime Ripard   2013-11-07   37  
67905540 Maxime Ripard   2013-11-07   38  #define TIMER_SYNC_TICKS	3
67905540 Maxime Ripard   2013-11-07   39  
4a59058f Maxime Ripard   2015-03-31   40  struct sun5i_timer {
4a59058f Maxime Ripard   2015-03-31   41  	void __iomem		*base;
4a59058f Maxime Ripard   2015-03-31   42  	struct clk		*clk;
3071efa4 Maxime Ripard   2015-03-31   43  	struct notifier_block	clk_rate_cb;
4a59058f Maxime Ripard   2015-03-31   44  	u32			ticks_per_jiffy;
4a59058f Maxime Ripard   2015-03-31   45  };
4a59058f Maxime Ripard   2015-03-31   46  
3071efa4 Maxime Ripard   2015-03-31   47  #define to_sun5i_timer(x) \
3071efa4 Maxime Ripard   2015-03-31   48  	container_of(x, struct sun5i_timer, clk_rate_cb)
3071efa4 Maxime Ripard   2015-03-31   49  
4a59058f Maxime Ripard   2015-03-31   50  struct sun5i_timer_clksrc {
4a59058f Maxime Ripard   2015-03-31   51  	struct sun5i_timer	timer;
4a59058f Maxime Ripard   2015-03-31  @52  	struct clocksource	clksrc;
4a59058f Maxime Ripard   2015-03-31   53  };
4a59058f Maxime Ripard   2015-03-31   54  
4a59058f Maxime Ripard   2015-03-31   55  #define to_sun5i_timer_clksrc(x) \
4a59058f Maxime Ripard   2015-03-31  @56  	container_of(x, struct sun5i_timer_clksrc, clksrc)
4a59058f Maxime Ripard   2015-03-31   57  
4a59058f Maxime Ripard   2015-03-31   58  struct sun5i_timer_clkevt {
4a59058f Maxime Ripard   2015-03-31   59  	struct sun5i_timer		timer;
4a59058f Maxime Ripard   2015-03-31  @60  	struct clock_event_device	clkevt;
4a59058f Maxime Ripard   2015-03-31   61  };
4a59058f Maxime Ripard   2015-03-31   62  
4a59058f Maxime Ripard   2015-03-31   63  #define to_sun5i_timer_clkevt(x) \
4a59058f Maxime Ripard   2015-03-31  @64  	container_of(x, struct sun5i_timer_clkevt, clkevt)
67905540 Maxime Ripard   2013-11-07   65  
67905540 Maxime Ripard   2013-11-07   66  /*
67905540 Maxime Ripard   2013-11-07   67   * When we disable a timer, we need to wait at least for 2 cycles of
67905540 Maxime Ripard   2013-11-07   68   * the timer source clock. We will use for that the clocksource timer
67905540 Maxime Ripard   2013-11-07   69   * that is already setup and runs at the same frequency than the other
67905540 Maxime Ripard   2013-11-07   70   * timers, and we never will be disabled.
67905540 Maxime Ripard   2013-11-07   71   */
4a59058f Maxime Ripard   2015-03-31   72  static void sun5i_clkevt_sync(struct sun5i_timer_clkevt *ce)
67905540 Maxime Ripard   2013-11-07   73  {
4a59058f Maxime Ripard   2015-03-31   74  	u32 old = readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1));
67905540 Maxime Ripard   2013-11-07   75  
4a59058f Maxime Ripard   2015-03-31   76  	while ((old - readl(ce->timer.base + TIMER_CNTVAL_LO_REG(1))) < TIMER_SYNC_TICKS)
67905540 Maxime Ripard   2013-11-07   77  		cpu_relax();
67905540 Maxime Ripard   2013-11-07   78  }
67905540 Maxime Ripard   2013-11-07   79  
4a59058f Maxime Ripard   2015-03-31   80  static void sun5i_clkevt_time_stop(struct sun5i_timer_clkevt *ce, u8 timer)
67905540 Maxime Ripard   2013-11-07   81  {
4a59058f Maxime Ripard   2015-03-31   82  	u32 val = readl(ce->timer.base + TIMER_CTL_REG(timer));
4a59058f Maxime Ripard   2015-03-31   83  	writel(val & ~TIMER_CTL_ENABLE, ce->timer.base + TIMER_CTL_REG(timer));
67905540 Maxime Ripard   2013-11-07   84  
4a59058f Maxime Ripard   2015-03-31   85  	sun5i_clkevt_sync(ce);
67905540 Maxime Ripard   2013-11-07   86  }
67905540 Maxime Ripard   2013-11-07   87  
4a59058f Maxime Ripard   2015-03-31   88  static void sun5i_clkevt_time_setup(struct sun5i_timer_clkevt *ce, u8 timer, u32 delay)
67905540 Maxime Ripard   2013-11-07   89  {
4a59058f Maxime Ripard   2015-03-31   90  	writel(delay, ce->timer.base + TIMER_INTVAL_LO_REG(timer));
67905540 Maxime Ripard   2013-11-07   91  }
67905540 Maxime Ripard   2013-11-07   92  
4a59058f Maxime Ripard   2015-03-31   93  static void sun5i_clkevt_time_start(struct sun5i_timer_clkevt *ce, u8 timer, bool periodic)
67905540 Maxime Ripard   2013-11-07   94  {
4a59058f Maxime Ripard   2015-03-31   95  	u32 val = readl(ce->timer.base + TIMER_CTL_REG(timer));
67905540 Maxime Ripard   2013-11-07   96  
67905540 Maxime Ripard   2013-11-07   97  	if (periodic)
67905540 Maxime Ripard   2013-11-07   98  		val &= ~TIMER_CTL_ONESHOT;
67905540 Maxime Ripard   2013-11-07   99  	else
67905540 Maxime Ripard   2013-11-07  100  		val |= TIMER_CTL_ONESHOT;
67905540 Maxime Ripard   2013-11-07  101  
67905540 Maxime Ripard   2013-11-07  102  	writel(val | TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
4a59058f Maxime Ripard   2015-03-31  103  	       ce->timer.base + TIMER_CTL_REG(timer));
67905540 Maxime Ripard   2013-11-07  104  }
67905540 Maxime Ripard   2013-11-07  105  
7486f5ad Viresh Kumar    2015-06-18  106  static int sun5i_clkevt_shutdown(struct clock_event_device *clkevt)
67905540 Maxime Ripard   2013-11-07  107  {
4a59058f Maxime Ripard   2015-03-31 @108  	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
4a59058f Maxime Ripard   2015-03-31  109  
4a59058f Maxime Ripard   2015-03-31  110  	sun5i_clkevt_time_stop(ce, 0);
7486f5ad Viresh Kumar    2015-06-18  111  	return 0;
7486f5ad Viresh Kumar    2015-06-18  112  }
7486f5ad Viresh Kumar    2015-06-18  113  
7486f5ad Viresh Kumar    2015-06-18  114  static int sun5i_clkevt_set_oneshot(struct clock_event_device *clkevt)
7486f5ad Viresh Kumar    2015-06-18  115  {
7486f5ad Viresh Kumar    2015-06-18  116  	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
7486f5ad Viresh Kumar    2015-06-18  117  
4a59058f Maxime Ripard   2015-03-31  118  	sun5i_clkevt_time_stop(ce, 0);
4a59058f Maxime Ripard   2015-03-31  119  	sun5i_clkevt_time_start(ce, 0, false);
7486f5ad Viresh Kumar    2015-06-18  120  	return 0;
67905540 Maxime Ripard   2013-11-07  121  }
7486f5ad Viresh Kumar    2015-06-18  122  
7486f5ad Viresh Kumar    2015-06-18  123  static int sun5i_clkevt_set_periodic(struct clock_event_device *clkevt)
7486f5ad Viresh Kumar    2015-06-18  124  {
7486f5ad Viresh Kumar    2015-06-18  125  	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
7486f5ad Viresh Kumar    2015-06-18  126  
7486f5ad Viresh Kumar    2015-06-18  127  	sun5i_clkevt_time_stop(ce, 0);
7486f5ad Viresh Kumar    2015-06-18  128  	sun5i_clkevt_time_setup(ce, 0, ce->timer.ticks_per_jiffy);
7486f5ad Viresh Kumar    2015-06-18  129  	sun5i_clkevt_time_start(ce, 0, true);
7486f5ad Viresh Kumar    2015-06-18  130  	return 0;
67905540 Maxime Ripard   2013-11-07  131  }
67905540 Maxime Ripard   2013-11-07  132  
67905540 Maxime Ripard   2013-11-07  133  static int sun5i_clkevt_next_event(unsigned long evt,
4a59058f Maxime Ripard   2015-03-31  134  				   struct clock_event_device *clkevt)
67905540 Maxime Ripard   2013-11-07  135  {
4a59058f Maxime Ripard   2015-03-31  136  	struct sun5i_timer_clkevt *ce = to_sun5i_timer_clkevt(clkevt);
4a59058f Maxime Ripard   2015-03-31  137  
4a59058f Maxime Ripard   2015-03-31  138  	sun5i_clkevt_time_stop(ce, 0);
4a59058f Maxime Ripard   2015-03-31  139  	sun5i_clkevt_time_setup(ce, 0, evt - TIMER_SYNC_TICKS);
4a59058f Maxime Ripard   2015-03-31  140  	sun5i_clkevt_time_start(ce, 0, false);
67905540 Maxime Ripard   2013-11-07  141  
67905540 Maxime Ripard   2013-11-07  142  	return 0;
67905540 Maxime Ripard   2013-11-07  143  }
67905540 Maxime Ripard   2013-11-07  144  
67905540 Maxime Ripard   2013-11-07  145  static irqreturn_t sun5i_timer_interrupt(int irq, void *dev_id)
67905540 Maxime Ripard   2013-11-07  146  {
4a59058f Maxime Ripard   2015-03-31  147  	struct sun5i_timer_clkevt *ce = (struct sun5i_timer_clkevt *)dev_id;
67905540 Maxime Ripard   2013-11-07  148  
4a59058f Maxime Ripard   2015-03-31  149  	writel(0x1, ce->timer.base + TIMER_IRQ_ST_REG);
4a59058f Maxime Ripard   2015-03-31  150  	ce->clkevt.event_handler(&ce->clkevt);
67905540 Maxime Ripard   2013-11-07  151  
67905540 Maxime Ripard   2013-11-07  152  	return IRQ_HANDLED;
67905540 Maxime Ripard   2013-11-07  153  }
67905540 Maxime Ripard   2013-11-07  154  
a5a1d1c2 Thomas Gleixner 2016-12-21  155  static u64 sun5i_clksrc_read(struct clocksource *clksrc)
59387683 Chen-Yu Tsai    2016-10-18  156  {
59387683 Chen-Yu Tsai    2016-10-18 @157  	struct sun5i_timer_clksrc *cs = to_sun5i_timer_clksrc(clksrc);
59387683 Chen-Yu Tsai    2016-10-18  158  
59387683 Chen-Yu Tsai    2016-10-18  159  	return ~readl(cs->timer.base + TIMER_CNTVAL_LO_REG(1));
59387683 Chen-Yu Tsai    2016-10-18  160  }
59387683 Chen-Yu Tsai    2016-10-18  161  
3071efa4 Maxime Ripard   2015-03-31  162  static int sun5i_rate_cb_clksrc(struct notifier_block *nb,
3071efa4 Maxime Ripard   2015-03-31  163  				unsigned long event, void *data)
3071efa4 Maxime Ripard   2015-03-31  164  {
3071efa4 Maxime Ripard   2015-03-31  165  	struct clk_notifier_data *ndata = data;
3071efa4 Maxime Ripard   2015-03-31  166  	struct sun5i_timer *timer = to_sun5i_timer(nb);
3071efa4 Maxime Ripard   2015-03-31  167  	struct sun5i_timer_clksrc *cs = container_of(timer, struct sun5i_timer_clksrc, timer);
3071efa4 Maxime Ripard   2015-03-31  168  
3071efa4 Maxime Ripard   2015-03-31  169  	switch (event) {
3071efa4 Maxime Ripard   2015-03-31  170  	case PRE_RATE_CHANGE:
3071efa4 Maxime Ripard   2015-03-31 @171  		clocksource_unregister(&cs->clksrc);
3071efa4 Maxime Ripard   2015-03-31  172  		break;
3071efa4 Maxime Ripard   2015-03-31  173  
3071efa4 Maxime Ripard   2015-03-31  174  	case POST_RATE_CHANGE:
3071efa4 Maxime Ripard   2015-03-31 @175  		clocksource_register_hz(&cs->clksrc, ndata->new_rate);
3071efa4 Maxime Ripard   2015-03-31  176  		break;
3071efa4 Maxime Ripard   2015-03-31  177  
3071efa4 Maxime Ripard   2015-03-31  178  	default:
3071efa4 Maxime Ripard   2015-03-31  179  		break;
3071efa4 Maxime Ripard   2015-03-31  180  	}
3071efa4 Maxime Ripard   2015-03-31  181  
3071efa4 Maxime Ripard   2015-03-31  182  	return NOTIFY_DONE;
3071efa4 Maxime Ripard   2015-03-31  183  }
3071efa4 Maxime Ripard   2015-03-31  184  
4a59058f Maxime Ripard   2015-03-31  185  static int __init sun5i_setup_clocksource(struct device_node *node,
4a59058f Maxime Ripard   2015-03-31  186  					  void __iomem *base,
4a59058f Maxime Ripard   2015-03-31  187  					  struct clk *clk, int irq)
4a59058f Maxime Ripard   2015-03-31  188  {
4a59058f Maxime Ripard   2015-03-31  189  	struct sun5i_timer_clksrc *cs;
4a59058f Maxime Ripard   2015-03-31  190  	unsigned long rate;
4a59058f Maxime Ripard   2015-03-31  191  	int ret;
4a59058f Maxime Ripard   2015-03-31  192  
4a59058f Maxime Ripard   2015-03-31  193  	cs = kzalloc(sizeof(*cs), GFP_KERNEL);
4a59058f Maxime Ripard   2015-03-31  194  	if (!cs)
4a59058f Maxime Ripard   2015-03-31  195  		return -ENOMEM;
4a59058f Maxime Ripard   2015-03-31  196  
4a59058f Maxime Ripard   2015-03-31  197  	ret = clk_prepare_enable(clk);
4a59058f Maxime Ripard   2015-03-31  198  	if (ret) {
4a59058f Maxime Ripard   2015-03-31  199  		pr_err("Couldn't enable parent clock\n");
4a59058f Maxime Ripard   2015-03-31  200  		goto err_free;
4a59058f Maxime Ripard   2015-03-31  201  	}
4a59058f Maxime Ripard   2015-03-31  202  
4a59058f Maxime Ripard   2015-03-31  203  	rate = clk_get_rate(clk);
4a59058f Maxime Ripard   2015-03-31  204  
4a59058f Maxime Ripard   2015-03-31  205  	cs->timer.base = base;
4a59058f Maxime Ripard   2015-03-31  206  	cs->timer.clk = clk;
3071efa4 Maxime Ripard   2015-03-31  207  	cs->timer.clk_rate_cb.notifier_call = sun5i_rate_cb_clksrc;
3071efa4 Maxime Ripard   2015-03-31  208  	cs->timer.clk_rate_cb.next = NULL;
3071efa4 Maxime Ripard   2015-03-31  209  
3071efa4 Maxime Ripard   2015-03-31  210  	ret = clk_notifier_register(clk, &cs->timer.clk_rate_cb);
3071efa4 Maxime Ripard   2015-03-31  211  	if (ret) {
3071efa4 Maxime Ripard   2015-03-31  212  		pr_err("Unable to register clock notifier.\n");
3071efa4 Maxime Ripard   2015-03-31  213  		goto err_disable_clk;
3071efa4 Maxime Ripard   2015-03-31  214  	}
4a59058f Maxime Ripard   2015-03-31  215  
4a59058f Maxime Ripard   2015-03-31  216  	writel(~0, base + TIMER_INTVAL_LO_REG(1));
4a59058f Maxime Ripard   2015-03-31  217  	writel(TIMER_CTL_ENABLE | TIMER_CTL_RELOAD,
4a59058f Maxime Ripard   2015-03-31  218  	       base + TIMER_CTL_REG(1));
4a59058f Maxime Ripard   2015-03-31  219  
59387683 Chen-Yu Tsai    2016-10-18  220  	cs->clksrc.name = node->name;
59387683 Chen-Yu Tsai    2016-10-18  221  	cs->clksrc.rating = 340;
59387683 Chen-Yu Tsai    2016-10-18  222  	cs->clksrc.read = sun5i_clksrc_read;
59387683 Chen-Yu Tsai    2016-10-18 @223  	cs->clksrc.mask = CLOCKSOURCE_MASK(32);
59387683 Chen-Yu Tsai    2016-10-18 @224  	cs->clksrc.flags = CLOCK_SOURCE_IS_CONTINUOUS;
59387683 Chen-Yu Tsai    2016-10-18  225  
59387683 Chen-Yu Tsai    2016-10-18  226  	ret = clocksource_register_hz(&cs->clksrc, rate);
4a59058f Maxime Ripard   2015-03-31  227  	if (ret) {
4a59058f Maxime Ripard   2015-03-31  228  		pr_err("Couldn't register clock source.\n");
3071efa4 Maxime Ripard   2015-03-31  229  		goto err_remove_notifier;
4a59058f Maxime Ripard   2015-03-31  230  	}
4a59058f Maxime Ripard   2015-03-31  231  
4a59058f Maxime Ripard   2015-03-31  232  	return 0;
4a59058f Maxime Ripard   2015-03-31  233  
3071efa4 Maxime Ripard   2015-03-31  234  err_remove_notifier:
3071efa4 Maxime Ripard   2015-03-31  235  	clk_notifier_unregister(clk, &cs->timer.clk_rate_cb);
4a59058f Maxime Ripard   2015-03-31  236  err_disable_clk:
4a59058f Maxime Ripard   2015-03-31  237  	clk_disable_unprepare(clk);
4a59058f Maxime Ripard   2015-03-31  238  err_free:
4a59058f Maxime Ripard   2015-03-31  239  	kfree(cs);
4a59058f Maxime Ripard   2015-03-31  240  	return ret;
4a59058f Maxime Ripard   2015-03-31  241  }
4a59058f Maxime Ripard   2015-03-31  242  
3071efa4 Maxime Ripard   2015-03-31  243  static int sun5i_rate_cb_clkevt(struct notifier_block *nb,
3071efa4 Maxime Ripard   2015-03-31  244  				unsigned long event, void *data)
3071efa4 Maxime Ripard   2015-03-31  245  {
3071efa4 Maxime Ripard   2015-03-31  246  	struct clk_notifier_data *ndata = data;
3071efa4 Maxime Ripard   2015-03-31  247  	struct sun5i_timer *timer = to_sun5i_timer(nb);
3071efa4 Maxime Ripard   2015-03-31  248  	struct sun5i_timer_clkevt *ce = container_of(timer, struct sun5i_timer_clkevt, timer);
3071efa4 Maxime Ripard   2015-03-31  249  
3071efa4 Maxime Ripard   2015-03-31  250  	if (event == POST_RATE_CHANGE) {
3071efa4 Maxime Ripard   2015-03-31 @251  		clockevents_update_freq(&ce->clkevt, ndata->new_rate);
3071efa4 Maxime Ripard   2015-03-31  252  		ce->timer.ticks_per_jiffy = DIV_ROUND_UP(ndata->new_rate, HZ);
3071efa4 Maxime Ripard   2015-03-31  253  	}
3071efa4 Maxime Ripard   2015-03-31  254  

:::::: The code at line 52 was first introduced by commit
:::::: 4a59058f0b09682200c04b1db236b4a3b92128d7 clocksource/drivers/sun5i: Refactor the current code

:::::: TO: Maxime Ripard <maxime.ripard@free-electrons.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
SzlnzfESQP8PJr//IFrTAgA=

--82I3+IH0IqGh5yIs--
