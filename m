Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4F8481246
	for <linux-rtc@vger.kernel.org>; Fri,  7 Aug 2026 13:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107957; cv=none; b=uAXeC8OTx/G7/R9PMutqt/0nBB4HZW21yuYzIkeVrLydfzIt4D5oaPvDvq8TsQcLta+Z8E5VnGiG5iRHKAeXCezInIx2v5zFSYBXM7ZdHRrGAFp1Me0nkgyrXvB3iaz3F+0qHd9S7K8NSI4NzMMloFiEmKX0vVP5fzVDEvwKRNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107957; c=relaxed/simple;
	bh=n0Vn19nqj/lB2ugZp0+zOqsjg/7ogGYsadcpngMRmHY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=geMUKThiKPRVtF6YrkbnUMSkHF4DUBo3dY28N2HIkWIfHBUvgyEpuqqwXoANDizPadpDqjnXJrYa6uFXroFimqMJZ6pvVfTlGhuqgHtsHthjKTLysEs2D+uwCbj6eWsg6WNroxXP64ddW/tNSfs6pMGCwoXDll7hrTz0Mlg8aNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt9WZvly; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt9WZvly"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f633e6058so2832668f8f.0
        for <linux-rtc@vger.kernel.org>; Fri, 07 Aug 2026 06:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786107947; x=1786712747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c1a7P4jiviNU6oOtgbodYFwN4kHdnf0MCA2I2A5Ygzo=;
        b=Dt9WZvly3eyYjgmlfJO/HbzDz8YuJ7ZoVjab1/vpFWs6Xo+W9k/+yMxIqDJtK+Yx90
         E97c95yxO2H4ShfmYhY+QhisIGxBEaP1CFfTeLE0AfrCoaq0OMqBNQsL2jgC7JAGXwqp
         vSeRdK4pbM6xpLZ0K6U12koE6xJWJQ6lLk1v6aUUZkZMepqj4ysOicGrgkoxJdFHd65h
         Or7BBkec0AeQGDNriqkGz3Sliwn5TxT6kW5z6p2XiWdQuOhm4smni5SGTSb/L5Erw8Eg
         QWoaZODfkbl8PDIQDRPbh+EN+vSSLZ+6EU3v4B5OCMTBzs8usCyYO493jwRatuXYTdqf
         tJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786107947; x=1786712747;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c1a7P4jiviNU6oOtgbodYFwN4kHdnf0MCA2I2A5Ygzo=;
        b=syVeJMuvO37qOAI6/AJTy4a7r5JpM88GmzAAdvmUqXjsEIZpx13pqpExpts2muwrRM
         ogbtU4gCBF0HJP4UooS5o8lsth5v1UNuXRmza+57eF1/cVbqoMoWGPHYZx45IlvFIpsp
         SI4GfHFi+C+QIjR5zQjTCZEqEU6Xhy8npIJ1O6w6d2XiFlr9iIa7gabw3DrOivQxQ+MB
         b37sRlFAqd0eaCxDKsL60Moif21UhDko9GYPDUCGxclQ4qJpKdsUiA+/pQFJ3iblT5Vo
         sPdTUKJzLZuIb/hd2rNRDiDGP2ilhax66yJ+nT8q+k9MtqlDspg/baLdH/wdoa+VEl34
         0UDQ==
X-Forwarded-Encrypted: i=1; AHgh+RrAt6IM8lXF5CMcOxM0AyvOLDqB7eSX2sxNG/KTL/3s8jE9gVEq6Gpe9NZ3z/ZQyAp2BdCoU4OSEVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN6NgZ5pmiDxKnCiI4U4kwNmGDz8sqOz8t6uDnROryMzMuRBCB
	lQaR3AQGJyriOC2BUYJ5sNH5zBlns3A+xxNP4m9S6qljjqGknUXl+o2b
X-Gm-Gg: AR+sD13ajKOmFQaAVzP72qlHlAl0cr79SUOCSXpWwSotp5Ca/quAhRWSZJq3i/r+7tS
	iuZ5GYF3XlX/v+YrYf3ghRkmH8dqRaNk927RQFVuz56st5W2CJj5J34WVwwA2AQ2vp+FCIbMFYS
	xwnGN2hOlY2qq5Am4I8mlCK9Lyf2yuR1X4ENQPE1gBL1eAakWRQiFmcznxLOfB5ocq1e4aFe7cy
	VotQ6b3x/k1UeYR1GtlUCi4ZNxZjlx7b+La3FENLlo2L4gxQoE4onfMzx2rthAYBggS7bI6CWQQ
	TQueI4Ja56rbLKX6yU0yXfBrMqqJ7aC2u3XgvFR9EFl2iWXTTIfi9cTLjvBs2Y6SKfaehlOuN4A
	NMqm7FaKCZ474ZOm44VXSQnmkxSiRAn5z9Qs8lYTV+2gvXlCs01OCqA4rAcGO76qdTJOr+gRBMw
	WoRUD+wmsRJQb9ilXcSBXdKtLGOUyqrK9OsxAo/cEjeCu0UCnhOjibWzj/uN4dDonVrhM=
X-Received: by 2002:a05:6000:188f:b0:472:fe1a:1ee9 with SMTP id ffacd0b85a97d-47fec6334aemr37259511f8f.20.1786107947415;
        Fri, 07 Aug 2026 06:05:47 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4800220ab04sm5132001f8f.37.2026.08.07.06.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:05:46 -0700 (PDT)
Date: Fri, 7 Aug 2026 16:05:43 +0300
From: Dan Carpenter <error27@gmail.com>
To: oe-kbuild@lists.linux.dev, Elad Nachman <enachman@marvell.com>,
	alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, enachman@marvell.com
Subject: Re: [PATCH] drivers: rtc: handle OTF clock changes
Message-ID: <202608072059.hZ2oY5u0-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624123103.3523728-1-enachman@marvell.com>

Hi Elad,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elad-Nachman/drivers-rtc-handle-OTF-clock-changes/20260806-231215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
patch link:    https://lore.kernel.org/r/20260624123103.3523728-1-enachman%40marvell.com
patch subject: [PATCH] drivers: rtc: handle OTF clock changes
config: i386-randconfig-141 (https://download.01.org/0day-ci/archive/20260807/202608072059.hZ2oY5u0-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9187-g5189e3fb

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202608072059.hZ2oY5u0-lkp@intel.com/

smatch warnings:
drivers/rtc/interface.c:163 rtc_set_time() warn: variable dereferenced before check 'rtc' (see line 135)

vim +/rtc +163 drivers/rtc/interface.c

ab6a2d70d18edc David Brownell    2007-05-08  126  int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
0c86edc0d49706 Alessandro Zummo  2006-03-27  127  {
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  128  	int err, uie;
37b82b16c5f104 Elad Nachman      2026-06-24  129  	struct rtc_time new_tm;
0c86edc0d49706 Alessandro Zummo  2006-03-27  130  
0c86edc0d49706 Alessandro Zummo  2006-03-27  131  	err = rtc_valid_tm(tm);
0c86edc0d49706 Alessandro Zummo  2006-03-27  132  	if (err != 0)
0c86edc0d49706 Alessandro Zummo  2006-03-27  133  		return err;
0c86edc0d49706 Alessandro Zummo  2006-03-27  134  
4c4e5df1f346f7 Baolin Wang       2018-01-08 @135  	err = rtc_valid_range(rtc, tm);
4c4e5df1f346f7 Baolin Wang       2018-01-08  136  	if (err)
4c4e5df1f346f7 Baolin Wang       2018-01-08  137  		return err;
71db049e7355f3 Alexandre Belloni 2018-02-17  138  
989515647e7832 Baolin Wang       2018-01-08  139  	rtc_subtract_offset(rtc, tm);
989515647e7832 Baolin Wang       2018-01-08  140  
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  141  #ifdef CONFIG_RTC_INTF_DEV_UIE_EMUL
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  142  	uie = rtc->uie_rtctimer.enabled || rtc->uie_irq_active;
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  143  #else
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  144  	uie = rtc->uie_rtctimer.enabled;
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  145  #endif
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  146  	if (uie) {
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  147  		err = rtc_update_irq_enable(rtc, 0);
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  148  		if (err)
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  149  			return err;
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  150  	}
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  151  
0c86edc0d49706 Alessandro Zummo  2006-03-27  152  	err = mutex_lock_interruptible(&rtc->ops_lock);
0c86edc0d49706 Alessandro Zummo  2006-03-27  153  	if (err)
b68bb2632453a9 David Brownell    2008-07-29  154  		return err;
0c86edc0d49706 Alessandro Zummo  2006-03-27  155  
0c86edc0d49706 Alessandro Zummo  2006-03-27  156  	if (!rtc->ops)
0c86edc0d49706 Alessandro Zummo  2006-03-27  157  		err = -ENODEV;
bbccf83f6c4e1a Alessandro Zummo  2009-01-06  158  	else if (rtc->ops->set_time)
cd9662094edf41 David Brownell    2007-05-08  159  		err = rtc->ops->set_time(rtc->dev.parent, tm);
606cc43c720bde Alexandre Belloni 2019-03-20  160  	else
bbccf83f6c4e1a Alessandro Zummo  2009-01-06  161  		err = -EINVAL;
0c86edc0d49706 Alessandro Zummo  2006-03-27  162  
37b82b16c5f104 Elad Nachman      2026-06-24 @163  	if (rtc && rtc->ops && rtc->ops->read_time) {
                                                            ^^^
There is no point in checking "rtc" after we have already dereferenced
it.

37b82b16c5f104 Elad Nachman      2026-06-24  164  		if (!rtc->ops->read_time(rtc->dev.parent, &new_tm)) {
37b82b16c5f104 Elad Nachman      2026-06-24  165  			pr_debug("new rtc time secs %d mins %d hours %d mday %d mon %d year %d way %d yday %d dst %d\n",
37b82b16c5f104 Elad Nachman      2026-06-24  166  					new_tm.tm_sec, new_tm.tm_min,
37b82b16c5f104 Elad Nachman      2026-06-24  167  					new_tm.tm_hour, new_tm.tm_mday,
37b82b16c5f104 Elad Nachman      2026-06-24  168  					new_tm.tm_mon, new_tm.tm_year,
37b82b16c5f104 Elad Nachman      2026-06-24  169  					new_tm.tm_wday, new_tm.tm_yday,
37b82b16c5f104 Elad Nachman      2026-06-24  170  					new_tm.tm_isdst);
37b82b16c5f104 Elad Nachman      2026-06-24  171  		}
37b82b16c5f104 Elad Nachman      2026-06-24  172  	}
37b82b16c5f104 Elad Nachman      2026-06-24  173  
14d0e347ea2db5 Zoran Markovic    2013-06-26  174  	pm_stay_awake(rtc->dev.parent);
0c86edc0d49706 Alessandro Zummo  2006-03-27  175  	mutex_unlock(&rtc->ops_lock);
5f9679d29c7959 NeilBrown         2011-12-09  176  	/* A timer might have just expired */
5f9679d29c7959 NeilBrown         2011-12-09  177  	schedule_work(&rtc->irqwork);
29a1f599c0cc37 Baolin Wang       2017-12-14  178  
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  179  	if (uie) {
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  180  		err = rtc_update_irq_enable(rtc, 1);
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  181  		if (err)
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  182  			return err;
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  183  	}
7e7c005b4b1f1f Alexandre Belloni 2019-10-21  184  
29a1f599c0cc37 Baolin Wang       2017-12-14  185  	trace_rtc_set_time(rtc_tm_to_time64(tm), err);
0c86edc0d49706 Alessandro Zummo  2006-03-27  186  	return err;
0c86edc0d49706 Alessandro Zummo  2006-03-27  187  }

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

