Return-Path: <rtc-linux+bncBCQJP74GSUDRBBPLWS5AKGQEEMCYSKI@googlegroups.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com. [2607:f8b0:4001:c06::243])
        by gmr-mx.google.com with ESMTPS id b6si1008247ith.0.2016.05.30.23.56.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 May 2016 23:56:05 -0700 (PDT)
Received: by mail-io0-x243.google.com with SMTP id m17so14092662ioi.3
        for <rtc-linux@googlegroups.com>; Mon, 30 May 2016 23:56:05 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20160530203207.GY3451@piout.net>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
	<20160530203207.GY3451@piout.net>
Date: Tue, 31 May 2016 08:56:05 +0200
Message-ID: <CAMuHMdV5mcKZcBz=v7Pn2pbDiuwMpQYs-70e6NmH6CZ88=JNzA@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v4 00/16] genrtc removal
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>,
	Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
	David Howells <dhowells@redhat.com>, alpha <linux-alpha@vger.kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>,
	linux-m68k <linux-m68k@lists.linux-m68k.org>, RTCLINUX <rtc-linux@googlegroups.com>,
	Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Allo Alexandre,

On Mon, May 30, 2016 at 10:32 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 30/05/2016 at 20:57:48 +0200, Arnd Bergmann wrote :
>> This is the promised resend of the removal of the genrtc driver and some
>> related code, now that we are at a good time to merge this for the coming
>> merge window.
>>
>
> Thanks a lot!
>
> I'm applying the series right now so it sits in linux-next for a while
> before the next merge window.
>
> I would still happily take any acks, Reviewed-by or Tested-by tags.

Looks like Arnd forgot to include these when reposting:

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

For the m68k bits:
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
