Return-Path: <rtc-linux+bncBDJIP47K7MERB6HHX63QKGQEQM3KHSQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.136])
        by gmr-mx.google.com with ESMTPS id sf5si3881007pac.1.2016.03.21.06.15.36
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2016 06:15:36 -0700 (PDT)
Date: Mon, 21 Mar 2016 08:15:32 -0500
From: Rob Herring <robh@kernel.org>
To: Emil Bartczak <emilbart@gmail.com>
Cc: a.zummo@towertech.it, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH] drivers/rtc/rtc-mcp795.c: add devicetree support
Message-ID: <20160321131532.GA31244@rob-hp-laptop>
References: <20160321000610.GA21979@emba-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160321000610.GA21979@emba-laptop>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, Mar 21, 2016 at 01:06:10AM +0100, Emil Bartczak wrote:
> Add device tree support to the rtc-mcp795 driver.
> 
> Signed-off-by: Emil Bartczak <emilbart@gmail.com>
> ---
>  Documentation/devicetree/bindings/rtc/maxim,mcp795.txt | 11 +++++++++++
>  drivers/rtc/rtc-mcp795.c                               | 10 ++++++++++
>  2 files changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/maxim,mcp795.txt

Acked-by: Rob Herring <robh@kernel.org>

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
