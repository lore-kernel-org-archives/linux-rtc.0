Return-Path: <rtc-linux+bncBCEPJZEDQIBBBXMKTC6AKGQEJN2AELY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from ducie-dc1.codethink.co.uk (ducie-dc1.codethink.co.uk. [185.25.241.215])
        by gmr-mx.google.com with ESMTPS id r74si1026514wme.3.2016.07.13.02.09.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jul 2016 02:09:49 -0700 (PDT)
Subject: [rtc-linux] Re: [PATCH v3 2/4] meson-rtc: add device-tree binding
To: Frank Rowand <frowand.list@gmail.com>,
 linux-kernel@lists.codethink.co.uk, linux-amlogic@lists.infradead.org,
 rtc-linux@googlegroups.com
References: <1467748122-14833-1-git-send-email-ben.dooks@codethink.co.uk>
 <1467748122-14833-4-git-send-email-ben.dooks@codethink.co.uk>
 <5785D83C.2000809@gmail.com>
Cc: a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 devicetree@vger.kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
 Mark Rutland <mark.rutland@arm.com>
From: Ben Dooks <ben.dooks@codethink.co.uk>
Message-ID: <51411c13-8cb4-3623-f70e-03b4190655f2@codethink.co.uk>
Date: Wed, 13 Jul 2016 10:09:44 +0100
MIME-Version: 1.0
In-Reply-To: <5785D83C.2000809@gmail.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 13/07/16 06:57, Frank Rowand wrote:
> On 07/05/16 12:48, Ben Dooks wrote:
>> Add documentation for the AMLogic Meson RTC.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../devicetree/bindings/rtc/rtc-amlogic.txt         | 21 +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-amlogic.txt
> 
> Hi Ben,
> 
> I suspect you already know this since you have Rob's ack, but you need to
> send bindings to
> 
>   Rob Herring <robh+dt@kernel.org>
>   Mark Rutland <mark.rutland@arm.com>

Sorry, missed copying the email when sending.

I hope he's seen them from being on the devicetree@vger.kernel.org
list? I've added him as an CC: on this one to check.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
