Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39877336892;
	Fri, 14 Aug 2026 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728629; cv=none; b=escPnPQwH79I2k2v68MpeeeEQox+ACHdtfgQLBAGxsNfeba8BuHsoHmAMFcY1NQaPmFn+e86DrzE1vVUldr9IY7X9fomX1hMwDbUS8q1rfKTJ29+8kRCzZCm+IojzdlTkQNUHNte6Ex0Ryj9HCvITeIPb7vHGwB7MOg2HAGf7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728629; c=relaxed/simple;
	bh=BNptNXeW8m7e3RgY9Oc6vxp2cYfhqigMEmkq59/6RNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBFBxdAzISXzEV6K5LssHaSfF5Bu58dc4O809gw2ihTKGCZUGP9Fgi0DZW3qeCncDTEYPj+nHqUhA6QREZSPzK7TDvE04hHZooErKUVptNXi7AXQRGe1w+TFv7z8nLkpO1/+1x7fwZxlstC+pMJvaJHvD9KexkLetj+n6LVqILM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqktkY7s; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqktkY7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786728627; x=1818264627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BNptNXeW8m7e3RgY9Oc6vxp2cYfhqigMEmkq59/6RNU=;
  b=PqktkY7s2CqpCCL+wzXhKkFbENSHjhUvcgGg+xtu5nnuHTpxzfwWW6/F
   48sXNOYbwBhXM/AgyXwGkUeQMQnwcnNE0p8d5jEzOFuFi0MRU9JpffLn8
   D28fnXrmHySS3TR+n/TnFFBD37MEXbhf8w1GqKoAvFqzJH/YWOUp8BYzU
   L5qUQMk6hFTF2s2UGBjfKKAD9kKCnyOuSB8k64pDsnyduDM+BmbHO6B0+
   9VGrETItu+TXAj0b07Sm1Doa4Bb1P+8uBtU65ZJ7KAvNz/XH3oTdARySe
   Vc6O/yOEzkIHrpu+ge+ScJa6upVHR3Z+OSGQCZDgh/kmctrrGIo5RiNSN
   A==;
X-CSE-ConnectionGUID: sF0yK5nwTdCUjIcpN47Ukw==
X-CSE-MsgGUID: rdxTuu3qTrm0ygr7mv4FmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11875"; a="98669001"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="98669001"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 10:30:27 -0700
X-CSE-ConnectionGUID: qbSh3vsJS0Wh5AFcpl5o1A==
X-CSE-MsgGUID: ON7jX+dvTDaq+C0NrZW8HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="268133972"
Received: from lkp-server01.sh.intel.com (HELO 6eda058d650d) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 14 Aug 2026 10:30:24 -0700
Received: from kbuild by 6eda058d650d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wuvjZ-00000000Zhm-3Rnv;
	Fri, 14 Aug 2026 17:30:21 +0000
Date: Sat, 15 Aug 2026 01:30:15 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, linux-rtc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] rtc: stmp3xxx: use devm_platform_ioremap_resource()
Message-ID: <202608150130.OdnZnae5-lkp@intel.com>
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
[also build test ERROR on linus/master v7.2-rc7 next-20260813]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/rtc-stmp3xxx-use-devm_platform_ioremap_resource/20260814-172225
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20260728005303.574936-1-rosenp%40gmail.com
patch subject: [PATCHv2] rtc: stmp3xxx: use devm_platform_ioremap_resource()
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20260815/202608150130.OdnZnae5-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260815/202608150130.OdnZnae5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608150130.OdnZnae5-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/rtc/rtc-stmp3xxx.c: In function 'stmp3xxx_rtc_probe':
>> drivers/rtc/rtc-stmp3xxx.c:253:9: error: 'irq_alarm' undeclared (first use in this function)
     253 |         irq_alarm = platform_get_irq(pdev, 0);
         |         ^~~~~~~~~
   drivers/rtc/rtc-stmp3xxx.c:253:9: note: each undeclared identifier is reported only once for each function it appears in


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
