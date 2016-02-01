Return-Path: <rtc-linux+bncBCNNJWF7RUMRBF4NX62QKGQE4XIBXBQ@googlegroups.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com. [2607:f8b0:400e:c00::243])
        by gmr-mx.google.com with ESMTPS id jg4si3561805pac.2.2016.02.01.12.56.55
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2016 12:56:55 -0800 (PST)
Received: by mail-pf0-x243.google.com with SMTP id 65so7974890pfd.1
        for <rtc-linux@googlegroups.com>; Mon, 01 Feb 2016 12:56:55 -0800 (PST)
Date: Mon, 1 Feb 2016 12:56:48 -0800
From: Joshua Clayton <stillcompiling@gmail.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
 linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 7/8] rtc: implement a sysfs interface for
 clock offset
Message-ID: <20160201125648.37475997@jclayton-pc>
In-Reply-To: <20160131114115.GJ20165@piout.net>
References: <0000-cover-letter.patch>
	<8361752a4e0c524e15cbed36d03eb3eb9b187815.1451929910.git.stillcompiling@gmail.com>
	<20160131114115.GJ20165@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Sun, 31 Jan 2016 12:41:15 +0100
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> Hi,
> 
> On 04/01/2016 at 10:31:25 -0800, Joshua Clayton wrote :
> > The file is called "offset", and may be set and read in decimal.
> > For rtcs that do not have read_offset or set_offset implemented,
> > read always returns zero and write will return -EINVAL.
> > 
> Can you expand rtc_attr_is_visible() instead of having the offset file
> always present?

Yes, Absolutely.
I wanted to do something like this, but didn't know is_visible
existed... and no wonder. Its in attribute_group

> 
> Also, you need to expand Documentation/rtc.txt, section SYSFS
> INTERFACE.
> 
OK. Will do.

> I'm fine with having parts per billion as the unit and I hope we won't
> ever need anything more precise :)
> 
It is orders of magnitude more than needed at present
...and no will ever need more than 640k of memory... right?

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
