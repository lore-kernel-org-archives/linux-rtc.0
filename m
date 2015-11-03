Return-Path: <rtc-linux+bncBDZJXP7F6YLRBT524GYQKGQEVZ4FOAI@googlegroups.com>
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr. [192.134.164.83])
        by gmr-mx.google.com with ESMTPS id t2si606478wme.1.2015.11.02.23.07.58
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2015 23:07:59 -0800 (PST)
Date: Tue, 3 Nov 2015 08:07:57 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
cc: kbuild-all@01.org, Alessandro Zummo <a.zummo@towertech.it>,
    rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCHv2] rtc: Add a driver for Micro Crystal RV8803
In-Reply-To: <201511030710.GSjglrml%fengguang.wu@intel.com>
Message-ID: <alpine.DEB.2.02.1511030806570.2043@localhost6.localdomain6>
References: <201511030710.GSjglrml%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

It looks like it is worth a check.

julia

On Tue, 3 Nov 2015, kbuild test robot wrote:

> CC: kbuild-all@01.org
> In-Reply-To: <1446504512-9079-1-git-send-email-alexandre.belloni@free-electrons.com>
> TO: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
> CC: rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Hi Alexandre,
> 
> [auto build test WARNING on abelloni/rtc-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]
> 
> url:    https://github.com/0day-ci/linux/commits/Alexandre-Belloni/rtc-Add-a-driver-for-Micro-Crystal-RV8803/20151103-065235
> :::::: branch date: 51 minutes ago
> :::::: commit date: 51 minutes ago
> 
> >> drivers/rtc/rtc-rv8803.c:244:2-8: preceding lock on line 240
> 
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout f8c59e6bf4a130cb2f46cad981771dddecc406ff
> vim +244 drivers/rtc/rtc-rv8803.c
> 
> f8c59e6b Alexandre Belloni 2015-11-02  234  		time64_t alarm_time = rtc_tm_to_time64(&alrm->time);
> f8c59e6b Alexandre Belloni 2015-11-02  235  
> f8c59e6b Alexandre Belloni 2015-11-02  236  		alarm_time += 60 - alrm->time.tm_sec;
> f8c59e6b Alexandre Belloni 2015-11-02  237  		rtc_time64_to_tm(alarm_time, &alrm->time);
> f8c59e6b Alexandre Belloni 2015-11-02  238  	}
> f8c59e6b Alexandre Belloni 2015-11-02  239  
> f8c59e6b Alexandre Belloni 2015-11-02 @240  	spin_lock_irqsave(&rv8803->flags_lock, irqflags);
> f8c59e6b Alexandre Belloni 2015-11-02  241  
> f8c59e6b Alexandre Belloni 2015-11-02  242  	ret = i2c_smbus_read_i2c_block_data(client, RV8803_FLAG, 2, ctrl);
> f8c59e6b Alexandre Belloni 2015-11-02  243  	if (ret != 2)
> f8c59e6b Alexandre Belloni 2015-11-02 @244  		return ret < 0 ? ret : -EIO;
> f8c59e6b Alexandre Belloni 2015-11-02  245  
> f8c59e6b Alexandre Belloni 2015-11-02  246  	alarmvals[0] = bin2bcd(alrm->time.tm_min);
> f8c59e6b Alexandre Belloni 2015-11-02  247  	alarmvals[1] = bin2bcd(alrm->time.tm_hour);
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
