Return-Path: <rtc-linux+bncBDJIP47K7MERBQ6JZO5QKGQE6LNFU4Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com. [209.85.220.195])
        by gmr-mx.google.com with ESMTPS id u136si12890ywc.7.2016.06.28.13.57.39
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2016 13:57:39 -0700 (PDT)
Received: by mail-qk0-f195.google.com with SMTP id j2so5892513qkf.1
        for <rtc-linux@googlegroups.com>; Tue, 28 Jun 2016 13:57:39 -0700 (PDT)
Date: Tue, 28 Jun 2016 15:57:31 -0500
From: Rob Herring <robh@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, rtc-linux@googlegroups.com,
	a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
	devicetree@vger.kernel.org, frowand.list@gmail.com,
	linux-amlogic@lists.infradead.org
Subject: [rtc-linux] Re: [PATCH v2 2/4] meson-rtc: add device-tree binding
Message-ID: <20160628205731.GW3737@rob-hp-laptop>
References: <1467045849-495-1-git-send-email-ben.dooks@codethink.co.uk>
 <1467045849-495-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1467045849-495-3-git-send-email-ben.dooks@codethink.co.uk>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Jun 27, 2016 at 05:44:07PM +0100, Ben Dooks wrote:
> Add documentation for the AMLogic Meson RTC.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  .../devicetree/bindings/rtc/rtc-amlogic.txt         | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-amlogic.txt

Acked-by: Rob Herring <robh@kernel.org>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
