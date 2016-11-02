Return-Path: <rtc-linux+bncBCWZZUED64BBBQ7W43AAKGQEGSPATFY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mx1.redhat.com (mx1.redhat.com. [209.132.183.28])
        by gmr-mx.google.com with ESMTPS id p22si87028ywe.3.2016.11.02.03.09.07
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Nov 2016 03:09:07 -0700 (PDT)
Message-ID: <5819BB2B.7010404@redhat.com>
Date: Wed, 02 Nov 2016 06:08:43 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
CC: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Karsten Keil <isdn@linux-pingi.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steffen Klassert <klassert@mathematik.tu-chemnitz.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wim Van Sebroeck <wim@iguana.be>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Harry Wei <harryxiyou@gmail.com>,
        Tejun Heo <tj@kernel.org>, Harald Welte <laforge@gnumonks.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Anton Vorontsov <anton@enomsg.org>, Colin Cross <ccross@android.com>,
        Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
        Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        Shuah Khan <shuah@kernel.org>, Diego Viola <diego.viola@gmail.com>,
        =?UTF-8?B?IsOYeXZpbmQgQS4gSG9sbSI=?=
 <sunny@sunbase.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Greg Hackmann <ghackmann@google.com>,
        =?UTF-8?B?TWFudWVsIFDDqWdvdXJpw6ktR29ubmFyZA==?= <mpg@elzevir.fr>,
        Jiri Kosina <jkosina@suse.cz>, Li Zefan <lizefan@huawei.com>,
        Yuan Sun <sunyuan3@huawei.com>, Haosdent Huang <haosdent@gmail.com>,
        Li RongQing <roy.qing.li@gmail.com>,
        Masanari Iida <standby24x7@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        SeongJae Park <sj38.park@gmail.com>, Minchan Kim <minchan@kernel.org>,
        Markus Heiser <markus.heiser@darmarIT.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Askar Safin <safinaskar@mail.ru>, Thomas Gardner <tmg@fastmail.com>,
        Peter Loeffler <peter.loeffler@guruz.at>,
        Philippe Loctaux <phil@philippeloctaux.com>,
        Doug Smythies <doug.smythies@gmail.com>,
        Chris Metcalf <cmetcalf@ezchip.com>, Jakub Wilk <jwilk@jwilk.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Hannes Reinicke <hare@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Borislav Petkov <bp@suse.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        "seokhoon.yoon" <iamyooon@gmail.com>,
        Egor Uleyskiy <egor.ulieiskii@gmail.com>,
        Ryan Swan <ryan@ryanswan.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Oliver Neukum <oneukum@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Thomas Garnier <thgarnie@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Petr Mladek <pmladek@suse.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Yang Shi <yang.shi@linaro.org>,
        Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Darren Hart <dvhart@linux.intel.com>,
        Wei Jiangang <weijg.fnst@cn.fujitsu.com>, linux-acpi@vger.kernel.org,
        rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org,
        linux-wireless@vger.kernel.org, alsa-devel@alsa-project.org,
        kvm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@zh-kernel.org, linux-ide@vger.kernel.org,
        linux-can@vger.kernel.org, linux-nvdimm@ml01.01.org,
        devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v2 34/37] docs: fix locations of several
 documents that got moved
References: <cover.1476801354.git.mchehab@s-opensource.com> <28c1f5d3867174a7017e3f3d9e9e4ebb096ceed8.1476801354.git.mchehab@s-opensource.com> <20161019103442.GD1461@amd> <20161019115918.1162d16e@vento.lan> <20161102093154.GC23350@amd>
In-Reply-To: <20161102093154.GC23350@amd>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>



On 11/02/2016 05:31 AM, Pavel Machek wrote:
> Hi!
> 
>>> Dunno, but kernel-parameters.txt was already quite long... for a file
>>> that is referenced quite often. Adding admin-guide/ into the path does
>>> not really help.
>>
>> The big string name starts with Documentation/ :) There are some discussions 
>> about changing it to doc/ (or docs/). Also, as you said, kernel-parameters
>> is already a big name. Perhaps we could use, instead,
>>> "kernel-parms".
> 
> cmdline?

You would not believe the number of users I've dealt with that have confused
"cmdline/command line" (aka prompt) with "kernel parameter".  I go back and edit
customer debug requests to make sure there's no use of cmdline in place of
kernel parameter.

For the love of every customer facing engineer out there, please stop using
cmdline ;).

P.

> 
>> If we rename kernel-parameters.rst to kernel-parms.rst, plus the doc/ rename,
>> then the string size will actually reduce:
>>
>> -		(see Documentation/kernel-parameters.txt), the minimum possible
>> +		(see doc/admin-guide/kernel-parms.rst), the minimum possible
>>
>>> Maybe admin-guide should go directly into Documentation/ , as that's
>>> what our users are interested in?
>>
>> There are several problems if we keep them at Documentation/ dir:
>>
>> - We'll end by mixing documents already converted to ReST with documents
>>   not converted yet;
>>
>> - A rename is needed anyway, as Sphinx only accepts ReST files that end
>>   with the extension(s) defined at Documentation/conf.py (currently,
>>   .rst);
>>
>> - A partial documentation build is made by sub-directory. If we put
>>   files under /Documentation, there's no way to build just one
>>   book.
> 
> Well, documentation is primarily for users. I'm sure tools can adapt...
> 
>>> Plus, I'm not sure how many developers will figure out that process/
>>> is what describes kernel patch submission process. We have processes
>>> in the kernel, after all...
>>
>> Do you have a better idea?
> 
> development/ ?
> 
> Best regards,
> 									Pavel
> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
