Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EFD231C91;
	Tue, 25 Aug 2026 21:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787694552; cv=none; b=a3DA0Izl0NFfveOP6PwVIcqgCMkFVZaNkQ+WgcvNBgoTsv9moudtZhLnyoqcaCw5TZK7Ey0TOiGPAbeyHMkSHCrvcK5/YbYza+nSHr9PwMiwgqksUIZP7KTax3+1Ess5B9lxWq2uTW0i9BbTrGa6yU0FFDYPKw9jjs19ol5l9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787694552; c=relaxed/simple;
	bh=iB3iJIpaeOIAGFQcRGJ3kUrukKd06vNTAahyWN3RODE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5MtkTtRMx+9x5aA2xTjqXYSLKrINCgJteYqvMKlbQZFLf3ulA+CUyJTkjQoGyqo1TAP1JA0JIpEOYr7ughakPjZgW5ATClxUQWbGIgaBhd7KMkIbm8Z9/IofqHymG4tD/DKd+Kf7BspQA33lnymkB2E3zrpFXMFR8jAc14iyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1tvCzw+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1tvCzw+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787694544; x=1819230544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iB3iJIpaeOIAGFQcRGJ3kUrukKd06vNTAahyWN3RODE=;
  b=j1tvCzw+xbrvPpYtq/Nf/G1UD/F2Ucu/AzxfMG0YrqNHb471wBw4nRb1
   VhnAL5fx+k/xWdNclecvuPUvk5R/XTRP7DnPvYAMvU/r5eAtE7BcGjp7w
   61XSMqoRZwsVG5++n0D3ul88+wRptcxHo/epYeg1GW8UPNd6afTpKnr0V
   qZ6vonlMulygWbp8DOyweAuqUkbUvNm+N3+Z5qctAy64yxq0Wmy5ol5Xq
   VqalGocl0zxkulMsd20ESMEV9a6b3xd1dOYGm8hneyVuIiyd7jRmvWgRp
   InfY9yHmOAAoDqRlBPYh4X2vL8Pqa03g+V2+b5QbHrgsRU40DpPB/QJhj
   Q==;
X-CSE-ConnectionGUID: h85BPn2tRr2PveClwj2M2A==
X-CSE-MsgGUID: WrLr4gYpTKGDj+xsb7+NiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88227563"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="88227563"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 14:49:01 -0700
X-CSE-ConnectionGUID: sSXVMHspTkG5ZgURYSZq9g==
X-CSE-MsgGUID: 1OeZazf8TWOUGQUNOZDvLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="271188036"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Aug 2026 14:49:00 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wyz0r-000000006QV-1QAU;
	Tue, 25 Aug 2026 21:48:57 +0000
Date: Wed, 26 Aug 2026 05:48:25 +0800
From: kernel test robot <lkp@intel.com>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>,
	linux-rtc@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf85063: disable the clkout output by default
Message-ID: <202608260554.ivtsRrZ9-lkp@intel.com>
References: <20260824080801.709764-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824080801.709764-1-alexander.sverdlin@siemens.com>

Hi Sverdlin,

kernel test robot noticed the following build errors:

[auto build test ERROR on abelloni/rtc-next]
[also build test ERROR on linus/master v7.2 next-20260824]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/A-Sverdlin/rtc-pcf85063-disable-the-clkout-output-by-default/20260824-100759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20260824080801.709764-1-alexander.sverdlin%40siemens.com
patch subject: [PATCH] rtc: pcf85063: disable the clkout output by default
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260826/202608260554.ivtsRrZ9-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260826/202608260554.ivtsRrZ9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608260554.ivtsRrZ9-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/rtc/rtc-pcf85063.c: In function 'pcf85063_clkout_register_clk':
>> drivers/rtc/rtc-pcf85063.c:527:9: error: 'ret' undeclared (first use in this function); did you mean 'net'?
     527 |         ret = regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
         |         ^~~
         |         net
   drivers/rtc/rtc-pcf85063.c:527:9: note: each undeclared identifier is reported only once for each function it appears in


vim +527 drivers/rtc/rtc-pcf85063.c

   497	
   498	static struct clk *pcf85063_clkout_register_clk(struct pcf85063 *pcf85063)
   499	{
   500		struct clk *clk;
   501		struct clk_init_data init = {};
   502		struct device_node *node = pcf85063->rtc->dev.parent->of_node;
   503		struct device_node *fixed_clock;
   504	
   505		fixed_clock = of_get_child_by_name(node, "clock");
   506		if (fixed_clock) {
   507			/*
   508			 * skip registering square wave clock when a fixed
   509			 * clock has been registered. The fixed clock is
   510			 * registered automatically when being referenced.
   511			 */
   512			of_node_put(fixed_clock);
   513			return NULL;
   514		}
   515	
   516		init.name = "pcf85063-clkout";
   517		init.ops = &pcf85063_clkout_ops;
   518		init.flags = 0;
   519		init.parent_names = NULL;
   520		init.num_parents = 0;
   521		pcf85063->clkout_hw.init = &init;
   522	
   523		/* optional override of the clockname */
   524		of_property_read_string(node, "clock-output-names", &init.name);
   525	
   526		/* power-on default is the 32768 Hz output on; gate it until claimed */
 > 527		ret = regmap_update_bits(pcf85063->regmap, PCF85063_REG_CTRL2,
   528					 PCF85063_REG_CLKO_F_MASK, PCF85063_REG_CLKO_F_OFF);
   529		if (ret)
   530			return ret;
   531	
   532		/* register the clock */
   533		clk = devm_clk_register(&pcf85063->rtc->dev, &pcf85063->clkout_hw);
   534	
   535		if (!IS_ERR(clk))
   536			of_clk_add_provider(node, of_clk_src_simple_get, clk);
   537	
   538		return clk;
   539	}
   540	#endif
   541	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
