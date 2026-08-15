Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B981A8F84;
	Sat, 15 Aug 2026 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786828233; cv=none; b=ZuxpI/Rvpyu4h8SnLZNwFAArVbKy3fPc2CSnc0twNnfaFshTbmg7NmOll17rIUd0vra1RQ2pbaOY51Px84U+0ZCYnsMs/ta9mdVJeEAmYhT9xOeQnRgB6tg6cTTD+oIBI4T5NIUHWm5oY4ou0Si+vvExsrNh1w6QE4i1zEPw4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786828233; c=relaxed/simple;
	bh=zGE7sbSEsg1VL/+akG79tvki9HQ5qphIDuggPzeAIWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DjlfPJq7queWoZr8iYpFF8uXzRRqRLeqnXZ7VIOVzvJOSMTsxr4f9HfaKAdt6KsQOL5W+pDGOjv+alY4hX2AT7EaT0DUs7ah4fTWpCVjFpRbpGxLm9JjulMy6q/nxV1yW8yx0Qmfyeo03YVCcb+WXRLdsMzDdqPtNE8qpF5QxKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HfaVKCqU; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HfaVKCqU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786828231; x=1818364231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zGE7sbSEsg1VL/+akG79tvki9HQ5qphIDuggPzeAIWo=;
  b=HfaVKCqU97T+6GHFUvI1b7+/R2vZQr8AnIgb05m4Dr5vULcgKGhrvtU3
   9BeBDUzllOhNqtEACBMM6B1T3okSV4hGqW0W24MoYTpjbyG4L45fSEFMK
   nYraos0ax7vhIGG3ClYt5127dgVmPGTzA38uO1x41sg+91aJj2d/f6P6L
   Z9R2Kf8vVupwHnaXvVUaFMuxzCpWvVhI8q0AY7BWkBdIzvfkeBh3/m7hC
   ZkZE/a11JdHj3ZEDVeB8cNMYe2f2eEUhScbxS1K9g1xVV6ql6WdQGNTqX
   Y5rhj9C/+1QJ5QArLSOj9fM/prmMN6HAIq4dB4e6C8tm6eodvzM3rFSPr
   A==;
X-CSE-ConnectionGUID: Ju0FkalxS+iS3VroYn906g==
X-CSE-MsgGUID: j++y0ff5Q7eE14mu1NyqLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11876"; a="104898572"
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; 
   d="scan'208";a="104898572"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2026 14:10:30 -0700
X-CSE-ConnectionGUID: s1iV41BjQlKhDgs8UDS6lw==
X-CSE-MsgGUID: 0Xle1gCrRMKGXYfYIDIszg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,225,1779174000"; 
   d="scan'208";a="268388448"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Aug 2026 14:10:28 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvLe5-00000000cUc-0hmV;
	Sat, 15 Aug 2026 21:10:25 +0000
Date: Sun, 16 Aug 2026 05:10:01 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-rtc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] rtc: stmp3xxx: use devm_platform_ioremap_resource()
Message-ID: <202608160528.nJ2vs2QU-lkp@intel.com>
References: <20260728005303.574936-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728005303.574936-1-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on linus/master v7.2-rc7 next-20260814]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/rtc-stmp3xxx-use-devm_platform_ioremap_resource/20260814-172225
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20260728005303.574936-1-rosenp%40gmail.com
patch subject: [PATCHv2] rtc: stmp3xxx: use devm_platform_ioremap_resource()
config: um-randconfig-r071-20260815 (https://download.01.org/0day-ci/archive/20260816/202608160528.nJ2vs2QU-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
smatch: v0.5.0-9187-g5189e3fb
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260816/202608160528.nJ2vs2QU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608160528.nJ2vs2QU-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/rtc/rtc-stmp3xxx.c:14:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/rtc/rtc-stmp3xxx.c:253:2: error: use of undeclared identifier 'irq_alarm'
     253 |         irq_alarm = platform_get_irq(pdev, 0);
         |         ^~~~~~~~~
   drivers/rtc/rtc-stmp3xxx.c:254:6: error: use of undeclared identifier 'irq_alarm'
     254 |         if (irq_alarm < 0)
         |             ^~~~~~~~~
   drivers/rtc/rtc-stmp3xxx.c:255:10: error: use of undeclared identifier 'irq_alarm'
     255 |                 return irq_alarm;
         |                        ^~~~~~~~~
   drivers/rtc/rtc-stmp3xxx.c:352:37: error: use of undeclared identifier 'irq_alarm'
     352 |         err = devm_request_irq(&pdev->dev, irq_alarm,
         |                                            ^~~~~~~~~
   1 warning and 4 errors generated.


vim +/irq_alarm +253 drivers/rtc/rtc-stmp3xxx.c

   243	
   244	static int stmp3xxx_rtc_probe(struct platform_device *pdev)
   245	{
   246		struct stmp3xxx_rtc_data *rtc_data;
   247		void __iomem *io;
   248		u32 rtc_stat;
   249		u32 pers0_set, pers0_clr;
   250		u32 crystalfreq = 0;
   251		int err;
   252	
 > 253		irq_alarm = platform_get_irq(pdev, 0);
   254		if (irq_alarm < 0)
   255			return irq_alarm;
   256	
   257		io = devm_platform_ioremap_resource(pdev, 0);
   258		if (IS_ERR(io))
   259			return PTR_ERR(io);
   260	
   261		rtc_data = devm_kzalloc(&pdev->dev, sizeof(*rtc_data), GFP_KERNEL);
   262		if (!rtc_data)
   263			return -ENOMEM;
   264	
   265		rtc_data->io = io;
   266	
   267		rtc_stat = readl(rtc_data->io + STMP3XXX_RTC_STAT);
   268		if (!(rtc_stat & STMP3XXX_RTC_STAT_RTC_PRESENT)) {
   269			dev_err(&pdev->dev, "no device onboard\n");
   270			return -ENODEV;
   271		}
   272	
   273		platform_set_drvdata(pdev, rtc_data);
   274	
   275		/*
   276		 * Resetting the rtc stops the watchdog timer that is potentially
   277		 * running. So (assuming it is running on purpose) don't reset if the
   278		 * watchdog is enabled.
   279		 */
   280		if (readl(rtc_data->io + STMP3XXX_RTC_CTRL) &
   281		    STMP3XXX_RTC_CTRL_WATCHDOGEN) {
   282			dev_info(&pdev->dev,
   283				 "Watchdog is running, skip resetting rtc\n");
   284		} else {
   285			err = stmp_reset_block(rtc_data->io);
   286			if (err) {
   287				dev_err(&pdev->dev, "stmp_reset_block failed: %d\n",
   288					err);
   289				return err;
   290			}
   291		}
   292	
   293		/*
   294		 * Obviously the rtc needs a clock input to be able to run.
   295		 * This clock can be provided by an external 32k crystal. If that one is
   296		 * missing XTAL must not be disabled in suspend which consumes a
   297		 * lot of power. Normally the presence and exact frequency (supported
   298		 * are 32000 Hz and 32768 Hz) is detectable from fuses, but as reality
   299		 * proves these fuses are not blown correctly on all machines, so the
   300		 * frequency can be overridden in the device tree.
   301		 */
   302		if (rtc_stat & STMP3XXX_RTC_STAT_XTAL32000_PRESENT)
   303			crystalfreq = 32000;
   304		else if (rtc_stat & STMP3XXX_RTC_STAT_XTAL32768_PRESENT)
   305			crystalfreq = 32768;
   306	
   307		of_property_read_u32(pdev->dev.of_node, "stmp,crystal-freq",
   308				     &crystalfreq);
   309	
   310		switch (crystalfreq) {
   311		case 32000:
   312			/* keep 32kHz crystal running in low-power mode */
   313			pers0_set = STMP3XXX_RTC_PERSISTENT0_XTAL32_FREQ |
   314				STMP3XXX_RTC_PERSISTENT0_XTAL32KHZ_PWRUP |
   315				STMP3XXX_RTC_PERSISTENT0_CLOCKSOURCE;
   316			pers0_clr = STMP3XXX_RTC_PERSISTENT0_XTAL24MHZ_PWRUP;
   317			break;
   318		case 32768:
   319			/* keep 32.768kHz crystal running in low-power mode */
   320			pers0_set = STMP3XXX_RTC_PERSISTENT0_XTAL32KHZ_PWRUP |
   321				STMP3XXX_RTC_PERSISTENT0_CLOCKSOURCE;
   322			pers0_clr = STMP3XXX_RTC_PERSISTENT0_XTAL24MHZ_PWRUP |
   323				STMP3XXX_RTC_PERSISTENT0_XTAL32_FREQ;
   324			break;
   325		default:
   326			dev_warn(&pdev->dev,
   327				 "invalid crystal-freq specified in device-tree. Assuming no crystal\n");
   328			fallthrough;
   329		case 0:
   330			/* keep XTAL on in low-power mode */
   331			pers0_set = STMP3XXX_RTC_PERSISTENT0_XTAL24MHZ_PWRUP;
   332			pers0_clr = STMP3XXX_RTC_PERSISTENT0_XTAL32KHZ_PWRUP |
   333				STMP3XXX_RTC_PERSISTENT0_CLOCKSOURCE;
   334		}
   335	
   336		writel(pers0_set, rtc_data->io + STMP3XXX_RTC_PERSISTENT0 +
   337				STMP_OFFSET_REG_SET);
   338	
   339		writel(STMP3XXX_RTC_PERSISTENT0_ALARM_EN |
   340				STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE_EN |
   341				STMP3XXX_RTC_PERSISTENT0_ALARM_WAKE | pers0_clr,
   342			rtc_data->io + STMP3XXX_RTC_PERSISTENT0 + STMP_OFFSET_REG_CLR);
   343	
   344		writel(STMP3XXX_RTC_CTRL_ONEMSEC_IRQ_EN |
   345				STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
   346			rtc_data->io + STMP3XXX_RTC_CTRL + STMP_OFFSET_REG_CLR);
   347	
   348		rtc_data->rtc = devm_rtc_allocate_device(&pdev->dev);
   349		if (IS_ERR(rtc_data->rtc))
   350			return PTR_ERR(rtc_data->rtc);
   351	
   352		err = devm_request_irq(&pdev->dev, irq_alarm,
   353				stmp3xxx_rtc_interrupt, 0, "RTC alarm", &pdev->dev);
   354		if (err)
   355			return err;
   356	
   357		rtc_data->rtc->ops = &stmp3xxx_rtc_ops;
   358		rtc_data->rtc->range_max = U32_MAX;
   359	
   360		err = devm_rtc_register_device(rtc_data->rtc);
   361		if (err)
   362			return err;
   363	
   364		stmp3xxx_wdt_register(pdev);
   365		return 0;
   366	}
   367	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
