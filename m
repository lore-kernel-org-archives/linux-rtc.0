Return-Path: <rtc-linux+bncBDZJXP7F6YLRBAVHUW2AKGQEHN3L4YY@googlegroups.com>
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr. [192.134.164.83])
        by gmr-mx.google.com with ESMTPS id 202si2365188wmf.2.2016.01.03.08.59.46
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Jan 2016 08:59:46 -0800 (PST)
Date: Sun, 3 Jan 2016 17:59:45 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
To: SF Markus Elfring <elfring@users.sourceforge.net>
cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
    Alexandre Belloni <alexandre.belloni@free-electrons.com>,
    LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 7/8] rtc-ab-b5ze-s3: Delete an unnecessary
 variable in _abb5zes3_rtc_interrupt()
In-Reply-To: <56895246.3080302@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1601031757380.2074@localhost6.localdomain6>
References: <566ABCD9.1060404@users.sourceforge.net> <5688DF2D.6090204@users.sourceforge.net> <5688E229.4010400@users.sourceforge.net> <alpine.DEB.2.02.1601031348040.2053@localhost6.localdomain6> <56895246.3080302@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On Sun, 3 Jan 2016, SF Markus Elfring wrote:

> >> Pass the address of the data structure element "time" directly in calls
> >> of the function "rtc_update_irq" instead of an extra initialisation
> >> for one local variable at the beginning.
> > 
> > Why is it better?
> 
> I suggest to refer to the data item "rtc_data->rtc" directly because
> the variable "rtc" was read only in two if branches.
> Does it make sense then to reduce the variable allocation?

No.  That is the job of the compiler.  For a local variable whose address 
is never taken, the compiler can easily detect its live region, and place 
the initialization in an optimal way.

julia
