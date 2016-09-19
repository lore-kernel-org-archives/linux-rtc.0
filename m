Return-Path: <rtc-linux+bncBDAMN6NI5EERBU5YQG7QKGQEQU2J4VQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from Galois.linutronix.de (Galois.linutronix.de. [2a01:7a0:2:106d:700::1])
        by gmr-mx.google.com with ESMTPS id y6si1476505wmg.0.2016.09.19.14.44.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Sep 2016 14:44:50 -0700 (PDT)
Date: Mon, 19 Sep 2016 23:42:23 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Pratyush Anand <panand@redhat.com>
cc: mingo@kernel.org, alexandre.belloni@free-electrons.com, hpa@zytor.com,
    x86@kernel.org, rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org,
    prarit@redhat.com, dzickus@redhat.com, dyoung@redhat.com,
    a.zummo@towertech.it
Subject: [rtc-linux] Re: [PATCH] rtc/rtc-cmos: Initialize hpet timer before
 irq is registered
In-Reply-To: <19b150a2f1087b80757d62770d99833781e57b31.1473862685.git.panand@redhat.com>
Message-ID: <alpine.DEB.2.20.1609192341360.5524@nanos>
References: <19b150a2f1087b80757d62770d99833781e57b31.1473862685.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, 15 Sep 2016, Pratyush Anand wrote:
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Pratyush Anand <panand@redhat.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
