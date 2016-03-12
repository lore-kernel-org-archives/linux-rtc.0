Return-Path: <rtc-linux+bncBDS7HNEFSALRBP7SSC3QKGQE4G4F5AQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id 71si253736wmp.0.2016.03.12.07.43.58
        for <rtc-linux@googlegroups.com>;
        Sat, 12 Mar 2016 07:43:58 -0800 (PST)
Date: Sat, 12 Mar 2016 16:43:56 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	Renaud Cerrato <r.cerrato@til-technologies.fr>
Subject: [rtc-linux] Re: [PATCH 1/3] rtc: pcf2127: conver to use regmap
Message-ID: <20160312154356.GA2693@piout.net>
References: <1457713336-24262-1-git-send-email-akinobu.mita@gmail.com>
 <20160311181111.GC4620@piout.net>
 <CAC5umyiwEWMdjPs6iZCUT0cn6W=RrGHMjHL-gR74KcT=C+ECgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAC5umyiwEWMdjPs6iZCUT0cn6W=RrGHMjHL-gR74KcT=C+ECgA@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 13/03/2016 at 00:39:34 +0900, Akinobu Mita wrote :
> The reason is regmap_i2c_read() doesn't work for this device because the
> STOP condition is required between set register address and read register
> data.  (Fig 45. Bus protocol, reading from registers in PCF2127.pdf)
> 
> I'll update this patch by adding that comment.

That would be great. You also have a small typo in the subject line.
Apart from that, I'm ready to take the patches.

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
