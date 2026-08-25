Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8497E2DCF67;
	Tue, 25 Aug 2026 01:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787621736; cv=none; b=XiUdsuvU6zBlI5+ieB6pBhhhqRk6Ml+HC+gIWRnuWMeNQnVODZiwsEphmUEIhBz07ls64+OBnVDWdAAGpCHbPTcmIbyZGZH+pA1ZlxJsTgmMkugZ1YJag67J0zEGeOYoU8xsHTEcSJYSzmmSOElYl3XUtwSoRVnjRw8KQWNlU80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787621736; c=relaxed/simple;
	bh=KZiXTwpEBkXFrvDBOhOzm3cqE6D6cAorNpq39mn0cHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avpPjVkHdp/kt9ktwlfe1wyDfp9PpJU2az05cDEcbzOEHgh7QUasue2vUmqub3udMKVYIWiG+xbPfH7Oy55CU+RlogmehrsSR3CnqHO8wyrT/ZtAGd5QmTPyPiguVxugC6vLthl45ttwb7Ni5UFBLY6y677OsoZ3M4c8G7/a0UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SfEaXzGC; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SfEaXzGC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787621735; x=1819157735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KZiXTwpEBkXFrvDBOhOzm3cqE6D6cAorNpq39mn0cHY=;
  b=SfEaXzGCiDzTLxeP++tzNpkl4+sm8bntRsAdC03QrV4MMJZBRPfME26J
   Df9KlXrfZCW/yesKyJkYoDSSvV2KGv8NQ7ROkXfnhiImrtXy8KQpYvYtU
   xrxVgYvnitJlSJuEvQkilHWAvywsemFCSvrDXGCEGOJez2d9KOb+5I8B0
   5Wc8ZY/dYs3CkRh3om6kLup//7XkYsG6xO2cAxBUmM4hpQ6m6QR6CUAdb
   +QmMEKyLb5qUt+i+xhTrDRE3HCxfiZoLKByuUw350LG+ZlieTarcNsJfa
   QOIKBokDWrM3Z7MrJpsUfMOZYPTRPA3TRABr1k8OkcUQIB9LRIOKli3iW
   Q==;
X-CSE-ConnectionGUID: H0dX94JLS5exEtXWfKax8A==
X-CSE-MsgGUID: bqUg40wTQWq23+/V3nUw9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="75620698"
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="75620698"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 18:35:34 -0700
X-CSE-ConnectionGUID: 107CCkufRCGaHWykDk4BIg==
X-CSE-MsgGUID: BKl37O5tSaSkH30giCMKZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,241,1779174000"; 
   d="scan'208";a="269102837"
Received: from lkp-server01.sh.intel.com (HELO 3532383e6126) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 24 Aug 2026 18:35:32 -0700
Received: from kbuild by 3532383e6126 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wyg4R-000000004lf-2PMl;
	Tue, 25 Aug 2026 01:35:25 +0000
Date: Tue, 25 Aug 2026 09:34:32 +0800
From: kernel test robot <lkp@intel.com>
To: Dhaval Shiroya <dhaval.shiroya@siliconsignals.io>,
	alexandre.belloni@bootlin.com
Cc: oe-kbuild-all@lists.linux.dev,
	Dhaval Shiroya <dhaval.shiroya@siliconsignals.io>,
	linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rv3028: configure backup switch mode from device
 tree
Message-ID: <202608250920.y0Rb4vg9-lkp@intel.com>
References: <20260822092911.318342-1-dhaval.shiroya@siliconsignals.io>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822092911.318342-1-dhaval.shiroya@siliconsignals.io>

Hi Dhaval,

kernel test robot noticed the following build warnings:

[auto build test WARNING on abelloni/rtc-next]
[also build test WARNING on linus/master v7.2 next-20260821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dhaval-Shiroya/rtc-rv3028-configure-backup-switch-mode-from-device-tree/20260822-145911
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20260822092911.318342-1-dhaval.shiroya%40siliconsignals.io
patch subject: [PATCH] rtc: rv3028: configure backup switch mode from device tree
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260825/202608250920.y0Rb4vg9-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260825/202608250920.y0Rb4vg9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608250920.y0Rb4vg9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:15,
                    from include/linux/i2c.h:13,
                    from drivers/rtc/rtc-rv3028.c:15:
   drivers/rtc/rtc-rv3028.c: In function 'rv3028_set_bsm_from_dt':
>> drivers/rtc/rtc-rv3028.c:906:18: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'long unsigned int' [-Wformat=]
     906 |                  "setting backup switch mode to %u (reg 0x37: 0x%02x -> 0x%02x)\n",
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:160:58: note: in expansion of macro 'dev_fmt'
     160 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   drivers/rtc/rtc-rv3028.c:905:9: note: in expansion of macro 'dev_info'
     905 |         dev_info(&client->dev,
         |         ^~~~~~~~
   drivers/rtc/rtc-rv3028.c:906:78: note: format string is defined here
     906 |                  "setting backup switch mode to %u (reg 0x37: 0x%02x -> 0x%02x)\n",
         |                                                                           ~~~^
         |                                                                              |
         |                                                                              unsigned int
         |                                                                           %02lx


vim +906 drivers/rtc/rtc-rv3028.c

   857	
   858	/*
   859	 * Configure backup switchover mode from device tree.
   860	 *   0 = disabled
   861	 *   1 = DSM (Direct Switching Mode)  - switch when VDD < VBACKUP
   862	 *   3 = LSM (Level Switching Mode)   - switch when VDD < 2.0V
   863	 */
   864	static int rv3028_set_bsm_from_dt(struct rv3028_data *rv3028,
   865					  struct i2c_client *client)
   866	{
   867		u32 val_old, bsm_dt, bsm_bits;
   868		int ret;
   869	
   870		if (device_property_read_u32(&client->dev, "backup-switch-mode",
   871					     &bsm_dt))
   872			return 0;
   873	
   874		/* Validate and convert DT value to register bits */
   875		switch (bsm_dt) {
   876		case 0:
   877			bsm_bits = 0;
   878			break;
   879		case 1:
   880			bsm_bits = FIELD_PREP(RV3028_BACKUP_BSM, RV3028_BACKUP_BSM_DSM);
   881			break;
   882		case 3:
   883			bsm_bits = FIELD_PREP(RV3028_BACKUP_BSM, RV3028_BACKUP_BSM_LSM);
   884			break;
   885		default:
   886			dev_warn(&client->dev,
   887				 "invalid backup-switch-mode %u (use 0, 1, or 3)\n",
   888				 bsm_dt);
   889			return 0;
   890		}
   891	
   892		/* Read current BACKUP register */
   893		ret = regmap_read(rv3028->regmap, RV3028_BACKUP, &val_old);
   894		if (ret < 0)
   895			return ret;
   896	
   897		/* Check if BSM and FEDE already match desired values */
   898		if ((val_old & (RV3028_BACKUP_BSM | RV3028_BACKUP_FEDE)) ==
   899		    (bsm_bits | RV3028_BACKUP_FEDE)) {
   900			dev_dbg(&client->dev,
   901				"backup switch mode already set to %u\n", bsm_dt);
   902			return 0;
   903		}
   904	
   905		dev_info(&client->dev,
 > 906			 "setting backup switch mode to %u (reg 0x37: 0x%02x -> 0x%02x)\n",
   907			 bsm_dt, val_old,
   908			 (val_old & ~(RV3028_BACKUP_BSM | RV3028_BACKUP_FEDE)) |
   909			 bsm_bits | RV3028_BACKUP_FEDE);
   910	
   911		/* Set BSM and always enable FEDE as recommended by datasheet */
   912		return rv3028_update_cfg(rv3028, RV3028_BACKUP,
   913					 RV3028_BACKUP_BSM | RV3028_BACKUP_FEDE,
   914					 bsm_bits | RV3028_BACKUP_FEDE);
   915	}
   916	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
