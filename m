Return-Path: <rtc-linux+bncBDJIP47K7MERB25KWW5QKGQEAJZ25AA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f66.google.com (mail-oi0-f66.google.com. [209.85.218.66])
        by gmr-mx.google.com with ESMTPS id e5si233236ith.1.2016.06.24.08.44.43
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2016 08:44:43 -0700 (PDT)
Received: by mail-oi0-f66.google.com with SMTP id w141so18993599oia.0
        for <rtc-linux@googlegroups.com>; Fri, 24 Jun 2016 08:44:43 -0700 (PDT)
Date: Fri, 24 Jun 2016 10:44:42 -0500
From: Rob Herring <robh@kernel.org>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
Subject: [rtc-linux] Re: [PATCH v2 2/4] dt/bindings: Add bindings for Micro
 Crystal rv8803
Message-ID: <20160624154442.GA7439@rob-hp-laptop>
References: <1466577742-18824-1-git-send-email-dirk.behme@de.bosch.com>
 <1466577742-18824-3-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466577742-18824-3-git-send-email-dirk.behme@de.bosch.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Jun 22, 2016 at 08:42:20AM +0200, Dirk Behme wrote:
> From: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> 
> ... and Epson RX8900 real time clock
> 
> Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/rtc/epson,rx8900.txt       | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/epson,rx8900.txt

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
