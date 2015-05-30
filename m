Date: Sun, 31 May 2015 00:21:42 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: Jan Kardell <jan.kardell@telliq.com>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	LKML <linux-kernel@vger.kernel.org>,
	Vincent Donnefort <vdonnefort@gmail.com>,
	Dan Carpenter <dan.carpenter@oracle.com>, oen@telliq.com
Subject: Re: [rtc-linux] Re: [PATCH v2] rtc: pcf8563 fix: return -EINVAL if
 we read an invalid time.
Message-ID: <20150530222142.GM2185@piout.net>
References: <1432730896-13423-1-git-send-email-jan.kardell@telliq.com>
 <CAFLxGvzkfnLFJv+4AdsptU6+F4DMth0aa0OxBGzN8dQxau2G_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFLxGvzkfnLFJv+4AdsptU6+F4DMth0aa0OxBGzN8dQxau2G_Q@mail.gmail.com>
List-ID: <rtc-linux.googlegroups.com>

On 31/05/2015 at 00:16:39 +0200, Richard Weinberger wrote :
> On Wed, May 27, 2015 at 2:48 PM, Jan Kardell <jan.kardell@telliq.com> wrote:
> > Return -EINVAL if the voltage low bit is set to avoid getting a bogus
> > time at boot.
> > There was a comment stating that util-linux hwclock refuses to set a
> > new time if we return an error code on read, but at least the current
> > version do set the time as expected. Remove the comment and the check
> > for valid time, and let the rtc core check it for us.
> >
> > Changes in v2: Remove the test for invalid time. Change dev_err to
> > dev_info when voltage low is set.
> >
> > Signed-off-by: Jan Kardell <jan.kardell@telliq.com>
> > ---
> >  drivers/rtc/rtc-pcf8563.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
> > index 0ba7e59..6ce0a86 100644
> > --- a/drivers/rtc/rtc-pcf8563.c
> > +++ b/drivers/rtc/rtc-pcf8563.c
> > @@ -22,7 +22,7 @@
> >  #include <linux/of.h>
> >  #include <linux/err.h>
> >
> > -#define DRV_VERSION "0.4.3"
> > +#define DRV_VERSION "0.4.4"
> 
> Why do you need that?
> Isn't the kernel version enough? :)
> 

That's also what I'm thinking but I don't care enough to ask people to
remove those.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
