Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793848504;
	b=saawDZrQL7w4mij1uMFwZ2Zfo2KW4DG/5uc6NsbB8/7kCWqbd4CFo/WSBkK12/yNjbGy
	 A3gaH8Tm+1mrLPZ4wA+YdJcNE7MPhq30f8arNsq4vYN6n9DHhf5DrsR/uns5/0t75k1rd
	 88N9GwjA6ZyF4YLi4X+fluWk4OS8FExl16zjtiVbrNuK+2al4ak4usrtXe+zqdqYriMld
	 Evy2GbZ/U0Cu8A4XegJm1HYfErDbMXGCxym2z5NJBQr6/aejmu3gjMcewjScmtEoMeNl6
	 qSPbnTxw1KqUita1nHRjGR/F5lpyGAc1ySh+4/D0wztPD8TgLN2w6CsTqDMjQomc5/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793848504;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=029x0NMf520q1WMTUW38KmZdMvpoDqVv46AHekJeKhk=;
	b=TtiQiVmbc9nuPlc02uAc7YG4JLxPv3+xOHrpwyBqBpzSrkR+txAtBw74hIwVwPN/MiAJ
	 UKMmpVFUOs3xQotP0ePqdMBEOZpwcpAUCe1IuEFk+Du//xz+MiSKZBAhIFarJ776TKpkE
	 b5f7nItGAZ3xAyaU0O4PFNQzm66SkvTFRRrCp5u5nRK0k7NUEJ4NVcF521r++RR6Vajr4
	 q0DhMTcblKGy/rNH83EbTmsGk/5lSE+lZBnSce0Cq0drsAC+/JOyeK2vkLDdh+xIJyqtU
	 FyFTwz+gSXUPBpAEYsDjLel/jG7A/SmeDsNad78VG73B2N/whFtv9GgYN275nEZqINA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2D2XTCE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D0E606D826
	for <linux-rtc@vger.kernel.org>; Thu,  5 Nov 2026 03:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K2D2XTCE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79881F00919;
	Thu,  5 Nov 2026 03:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793848503;
	bh=029x0NMf520q1WMTUW38KmZdMvpoDqVv46AHekJeKhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K2D2XTCE1qoWb8x3EKqWMB/dNlXwrIs9qgyBkhldysgUfkyi7PQ0kT14qkj83/TEZ
	 tYAsmnWC6xy4qgfaH1yYT2Qv7abiK8d17Ln6cNM916FD0tC6mlbLUU8dadVzGQR4y/
	 fjIhQCTswGjpf+CiKWdQ4rX7G1QB8guiM+GBr2sTBNtcEgNg1qQjurqIpvJLnUb6Ox
	 wVGPx35Xwd6vxo8j3ZODVZb2HZwgKFsTjRyzNH2227I55H/yeereypXS8QJo56snpp
	 iIXuoOKAMHmS/uQGCwdsdGUc0fXk4M1GNh/kDvxJdf5cfQoC7Wfd89LnyW6Y4dWDwv
	 EdNOzrQHsS9/w==
Message-ID: <sashiko-outbox-198509@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] selftests: rtc: Support harness test filtering and
 arguments
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wake Liu" <wakel@google.com>
Cc: linux-rtc@vger.kernel.org, "Alexandre Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261105030834.3318480-1-wakel@google.com>
References: <20260910034821.2935214-1-wakel@google.com>
 <20261105030834.3318480-1-wakel@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 03:15:03 +0000
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] selftests: rtc: incomplete getopt() reset on -h/-l in main()
--

commit 9bed5ee7eee853de78b5dce8eb5280f5ed1c8688
Author: Wake Liu <wakel@google.com>

selftests: rtc: Support harness test filtering and arguments

This commit updates main() in rtctest.c to parse command-line options with
getopt() so kselftest harness flags can be passed alongside the optional RTC
device node path.

> diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selfte=
sts/rtc/rtctest.c
> index 552191fe1ca09..eb26d957835d7 100644
> --- a/tools/testing/selftests/rtc/rtctest.c
> +++ b/tools/testing/selftests/rtc/rtctest.c
> @@ -487,18 +487,44 @@ TEST_F_TIMEOUT(rtc, alarm_wkalm_set_minute, 65) {
>  int main(int argc, char **argv)
>  {
>  	int ret =3D -1;
> +	int opt, i;
> +	int non_opt =3D 0;
> +
> +	while ((opt =3D getopt(argc, argv, "dhlF:f:V:v:t:T:r:")) !=3D -1) {
> +		switch (opt) {
> +		case 'h':
> +			fprintf(stderr,
> +				"Usage: %s [-h|-l|-d] [-t|-T|-v|-V|-f|-F|-r name] [rtcdev]\n\n",
> +				argv[0]);
> +			optind =3D 1;
> +			return test_harness_run(argc, argv);
> +		case 'l':
> +			optind =3D 1;
> +			return test_harness_run(argc, argv);

[Severity: Medium]
What happens if -h or -l is passed as the first flag in a clustered short
option argument (such as -hd or -ld)?

When getopt() parses the first character in argv[1], optind is still 1 and
getopt()'s internal within-argument character cursor points to the second
character ('d'). Returning early from inside the getopt() loop after setting
optind =3D 1 does not reset that internal cursor when getopt() has not fini=
shed
consuming the current argument.

When main() calls test_harness_run() -> test_harness_argv_check():

tools/testing/selftests/kselftest_harness.h:test_harness_argv_check() {
    ...
    while ((opt =3D getopt(argc, argv, "dhlF:f:V:v:t:T:r:")) !=3D -1) {
        switch (opt) {
        ...
        case 'h':
            test_harness_usage(argv[0]);
            return KSFT_FAIL;
        case 'l':
            __test_harness_list_tests();
            return KSFT_FAIL;
        ...
        }
    }
    return KSFT_PASS;
}

getopt() in test_harness_argv_check() resumes at 'd' instead of re-reading
'h' or 'l', returns KSFT_PASS, and runs the full RTC test suite (while also
having bypassed the access(rtc_file, R_OK) check in main()).

Would it be better to let the getopt() loop finish scanning all options (for
example by recording a flag for -h/-l or resetting optind =3D 0 where suppo=
rted)
before calling test_harness_run()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105030834.3318=
480-1-wakel@google.com?part=3D1
