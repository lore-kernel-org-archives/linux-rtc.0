Return-Path: <rtc-linux+bncBDJ4N37Q6EERBQFLQOYQKGQET62F76Q@googlegroups.com>
Received: from mga02.intel.com (mga02.intel.com. [134.134.136.20])
        by gmr-mx.google.com with ESMTP id ce6si1401817pad.0.2015.10.16.03.47.28
        for <rtc-linux@googlegroups.com>;
        Fri, 16 Oct 2015 03:47:28 -0700 (PDT)
Date: Fri, 16 Oct 2015 18:46:41 +0800
From: kbuild test robot <lkp@intel.com>
To: Heiko Schocher <hs@denx.de>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
	Heiko Schocher <hs@denx.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Georg.Soffel@bosch-si.com, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>, devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2] rtc: pcf8563: add CLKOUT to common clock framework
Message-ID: <201510161800.lgrXcGri%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
In-Reply-To: <1444982369-26046-1-git-send-email-hs@denx.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi Heiko,

[auto build test WARNING on abelloni/rtc-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Heiko-Schocher/rtc-pcf8563-add-CLKOUT-to-common-clock-framework/20151016-160221
config: sh-ap325rxa_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sh 

All warnings (new ones prefixed by >>):

   drivers/rtc/rtc-pcf8563.c:87:17: error: field 'clkout_hw' has incomplete type
   drivers/rtc/rtc-pcf8563.c: In function 'pcf8563_clkout_recalc_rate':
   drivers/rtc/rtc-pcf8563.c:418:28: warning: initialization from incompatible pointer type [enabled by default]
>> drivers/rtc/rtc-pcf8563.c:418:28: warning: (near initialization for 'pcf8563') [enabled by default]
   drivers/rtc/rtc-pcf8563.c: In function 'pcf8563_clkout_set_rate':
   drivers/rtc/rtc-pcf8563.c:445:28: warning: initialization from incompatible pointer type [enabled by default]
   drivers/rtc/rtc-pcf8563.c:445:28: warning: (near initialization for 'pcf8563') [enabled by default]
   drivers/rtc/rtc-pcf8563.c: In function 'pcf8563_clkout_control':
   drivers/rtc/rtc-pcf8563.c:469:28: warning: initialization from incompatible pointer type [enabled by default]
   drivers/rtc/rtc-pcf8563.c:469:28: warning: (near initialization for 'pcf8563') [enabled by default]
   drivers/rtc/rtc-pcf8563.c: In function 'pcf8563_clkout_is_prepared':
   drivers/rtc/rtc-pcf8563.c:498:28: warning: initialization from incompatible pointer type [enabled by default]
   drivers/rtc/rtc-pcf8563.c:498:28: warning: (near initialization for 'pcf8563') [enabled by default]
   drivers/rtc/rtc-pcf8563.c: At top level:
   drivers/rtc/rtc-pcf8563.c:509:21: error: variable 'pcf8563_clkout_ops' has initializer but incomplete type
   drivers/rtc/rtc-pcf8563.c:510:2: error: unknown field 'prepare' specified in initializer
   drivers/rtc/rtc-pcf8563.c:510:2: warning: excess elements in struct initializer [enabled by default]
   drivers/rtc/rtc-pcf8563.c:510:2: warning: (near initialization for 'pcf8563_clkout_ops') [enabled by default]
   drivers/rtc/rtc-pcf8563.c:511:2: error: unknown field 'unprepare' specified in initializer
   drivers/rtc/rtc-pcf8563.c:511:2: warning: excess elements in struct initializer [enabled by default]
   drivers/rtc/rtc-pcf8563.c:511:2: warning: (near initialization for 'pcf8563_clkout_ops') [enabled by default]
   drivers/rtc/rtc-pcf8563.c:512:2: error: unknown field 'is_prepared' specified in initializer
   drivers/rtc/rtc-pcf8563.c:512:2: warning: excess elements in struct initializer [enabled by default]
   drivers/rtc/rtc-pcf8563.c:512:2: warning: (near initialization for 'pcf8563_clkout_ops') [enabled by default]
   drivers/rtc/rtc-pcf8563.c:513:2: error: unknown field 'recalc_rate' specified in initializer
   drivers/rtc/rtc-pcf8563.c:513:2: warning: excess elements in struct initializer [enabled by default]
   drivers/rtc/rtc-pcf8563.c:513:2: warning: (near initialization for 'pcf8563_clkout_ops') [enabled by default]
   drivers/rtc/rtc-pcf8563.c:514:2: error: unknown field 'round_rate' specified in initializer
   drivers/rtc/rtc-pcf8563.c:514:2: warning: excess elements in struct initializer [enabled by default]
   drivers/rtc/rtc-pcf8563.c:514:2: warning: (near initialization for 'pcf8563_clkout_ops') [enabled by default]
   drivers/rtc/rtc-pcf8563.c:515:2: error: unknown field 'set_rate' specified in initializer
   drivers/rtc/rtc-pcf8563.c:515:2: warning: excess elements in struct initializer [enabled by default]
   drivers/rtc/rtc-pcf8563.c:515:2: warning: (near initialization for 'pcf8563_clkout_ops') [enabled by default]
   drivers/rtc/rtc-pcf8563.c: In function 'pcf8563_clkout_register_clk':
   drivers/rtc/rtc-pcf8563.c:523:23: error: storage size of 'init' isn't known
   drivers/rtc/rtc-pcf8563.c:535:15: error: 'CLK_IS_ROOT' undeclared (first use in this function)
   drivers/rtc/rtc-pcf8563.c:535:15: note: each undeclared identifier is reported only once for each function it appears in
   drivers/rtc/rtc-pcf8563.c:544:2: error: implicit declaration of function 'clk_register' [-Werror=implicit-function-declaration]
   drivers/rtc/rtc-pcf8563.c:547:3: error: implicit declaration of function 'of_clk_add_provider' [-Werror=implicit-function-declaration]
   drivers/rtc/rtc-pcf8563.c:547:29: error: 'of_clk_src_simple_get' undeclared (first use in this function)
   drivers/rtc/rtc-pcf8563.c:523:23: warning: unused variable 'init' [-Wunused-variable]
   cc1: some warnings being treated as errors

vim +/pcf8563 +418 drivers/rtc/rtc-pcf8563.c

   402	/*
   403	 * Handling of the clkout
   404	 */
   405	
   406	#define clkout_hw_to_pcf8563(_hw) container_of(_hw, struct pcf8563, clkout_hw)
   407	
   408	static int clkout_rates[] = {
   409		32768,
   410		1024,
   411		32,
   412		1,
   413	};
   414	
   415	static unsigned long pcf8563_clkout_recalc_rate(struct clk_hw *hw,
   416							unsigned long parent_rate)
   417	{
 > 418		struct pcf8563 *pcf8563 = clkout_hw_to_pcf8563(hw);
   419		struct i2c_client *client = pcf8563->client;
   420		unsigned char buf;
   421		int ret = pcf8563_read_block_data(client, PCF8563_REG_CLKO, 1, &buf);
   422	
   423		if (ret < 0)
   424			return 0;
   425	
   426		buf &= PCF8563_REG_CLKO_F_MASK;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

--M9NhX3UHpAaciwkO
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AL3uwQAA

--M9NhX3UHpAaciwkO--
