Return-Path: <rtc-linux+bncBDS7HNEFSALRBW773K3AKGQEGLQOICI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id e130si139659wme.2.2016.03.02.02.26.34
        for <rtc-linux@googlegroups.com>;
        Wed, 02 Mar 2016 02:26:34 -0800 (PST)
Date: Wed, 2 Mar 2016 11:26:34 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Juergen Borleis <jbe@pengutronix.de>
Cc: kbuild test robot <fengguang.wu@intel.com>, rtc-linux@googlegroups.com,
	Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [abelloni:rtc-testing 55/55] drivers/rtc/rtc-pcf85063.c:72:19:
 warning: unused variable 'pcf85063'
Message-ID: <20160302102634.GN23985@piout.net>
References: <201603020626.sgWd959D%fengguang.wu@intel.com>
 <201603021044.29444.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <201603021044.29444.jbe@pengutronix.de>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 02/03/2016 at 10:44:29 +0100, Juergen Borleis wrote :
> Hi Alexandre,
> 
> On Tuesday 01 March 2016 23:17:45 kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git
> > rtc-testing head:   58992ebde059d7faeab4c18bc17713c3b4c31208
> > commit: 58992ebde059d7faeab4c18bc17713c3b4c31208 [55/55] rtc: pcf85063:
> > remove useless century handling config: x86_64-randconfig-x012-201609
> > (attached as .config)
> > reproduce:
> >         git checkout 58992ebde059d7faeab4c18bc17713c3b4c31208
> >         # save the attached .config to linux build tree
> >         make ARCH=x86_64
> >
> > All warnings (new ones prefixed by >>):
> >
> >    drivers/rtc/rtc-pcf85063.c: In function 'pcf85063_get_datetime':
> > >> drivers/rtc/rtc-pcf85063.c:72:19: warning: unused variable 'pcf85063'
> > >> [-Wunused-variable]
> >
> >      struct pcf85063 *pcf85063 = i2c_get_clientdata(client);
> >                       ^
> 
> Due to your removement of the useless century handling the last user of 'struct 
> pcf85063' is gone. Seems we can remove this struct entirely. What do you 
> think?
> 

Sure, that was also my reasoning when fixing that warning. I've sent
follow up patches.

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
