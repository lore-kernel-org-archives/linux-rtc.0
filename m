Return-Path: <rtc-linux+bncBDS7HNEFSALRBEG7RCYQKGQEJXPDRJA@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id o3si252743wiz.1.2015.10.17.04.22.55
        for <rtc-linux@googlegroups.com>;
        Sat, 17 Oct 2015 04:22:55 -0700 (PDT)
Date: Sat, 17 Oct 2015 13:22:53 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Zhen Lei <thunder.leizhen@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alessandro Zummo <a.zummo@towertech.it>,
	rtc-linux <rtc-linux@googlegroups.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Zefan Li <lizefan@huawei.com>, Xinwei Hu <huxinwei@huawei.com>,
	Tianhong Ding <dingtianhong@huawei.com>,
	Hanjun Guo <guohanjun@huawei.com>
Subject: [rtc-linux] Re: [PATCH 1/1] rtc: fix type information of rtc-proc
Message-ID: <20151017112253.GU3421@piout.net>
References: <1444297652-10328-1-git-send-email-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1444297652-10328-1-git-send-email-thunder.leizhen@huawei.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 08/10/2015 at 17:47:32 +0800, Zhen Lei wrote :
> Display the whole word of "alarm", make it look more comfortable.
> 

While this is nice, this will break scripts parsing that file for not
good technical reason. I guess we are stuck with legacy here.

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
