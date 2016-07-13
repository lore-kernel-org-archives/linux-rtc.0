Return-Path: <rtc-linux+bncBD3LJZVFUEJBBS5QS66AKGQEOOUVPKA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com. [2607:f8b0:400d:c09::244])
        by gmr-mx.google.com with ESMTPS id w1si68985yww.7.2016.07.12.22.57.31
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2016 22:57:31 -0700 (PDT)
Received: by mail-qk0-x244.google.com with SMTP id 82so2388842qko.1
        for <rtc-linux@googlegroups.com>; Tue, 12 Jul 2016 22:57:31 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3 2/4] meson-rtc: add device-tree binding
To: Ben Dooks <ben.dooks@codethink.co.uk>,
 linux-kernel@lists.codethink.co.uk, linux-amlogic@lists.infradead.org,
 rtc-linux@googlegroups.com
References: <1467748122-14833-1-git-send-email-ben.dooks@codethink.co.uk>
 <1467748122-14833-4-git-send-email-ben.dooks@codethink.co.uk>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 devicetree@vger.kernel.org, narmstrong@baylibre.com, khilman@baylibre.com
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <5785D83C.2000809@gmail.com>
Date: Tue, 12 Jul 2016 22:57:16 -0700
MIME-Version: 1.0
In-Reply-To: <1467748122-14833-4-git-send-email-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 07/05/16 12:48, Ben Dooks wrote:
> Add documentation for the AMLogic Meson RTC.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/rtc/rtc-amlogic.txt         | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-amlogic.txt

Hi Ben,

I suspect you already know this since you have Rob's ack, but you need to
send bindings to

  Rob Herring <robh+dt@kernel.org>
  Mark Rutland <mark.rutland@arm.com>

-Frank

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
