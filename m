Return-Path: <rtc-linux+bncBDS7HNEFSALRB654RSZAKGQE6MO5I4A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id l1si648312wmb.1.2015.11.11.02.54.50
        for <rtc-linux@googlegroups.com>;
        Wed, 11 Nov 2015 02:54:50 -0800 (PST)
Date: Wed, 11 Nov 2015 11:54:50 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux <rtc-linux@googlegroups.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Zefan Li <lizefan@huawei.com>,
	Xinwei Hu <huxinwei@huawei.com>,
	Tianhong Ding <dingtianhong@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [rtc-linux] Re: [PATCH 1/1] rtc: fix type information of rtc-proc
Message-ID: <20151111105450.GC4519@piout.net>
References: <1444297652-10328-1-git-send-email-thunder.leizhen@huawei.com>
 <564294AB.1080500@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <564294AB.1080500@huawei.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 11/11/2015 at 09:06:51 +0800, Leizhen (ThunderTown) wrote :
> Hi, all
> 
> I'm sorry. Maybe I didn't describe clearly enough before. These words are finally
> shown to the end user. The end user maybe not a programmer, abbreviation word is unsuitable.
> 

Yes, that is exactly m point. What if an end user currently has a
program parsing the file and looking for alrm_time or alrm_date? After
updating his kernel, the program won't work anymore which is something
we don't want.

> 
> cat /proc/driver/rtc
> 
> rtc_time        : 00:47:43
> rtc_date        : 2015-11-11
> alrm_time       : 03:27:58				//alrm_time --> alarm_time
> alrm_date       : 2015-10-08				//alrm_date --> alarm_date
> alarm_IRQ       : no
> alrm_pending    : no					//alrm_pending --> alarm_pending
> update IRQ enabled      : no
> 
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
