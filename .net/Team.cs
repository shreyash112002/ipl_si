using System.ComponentModel.DataAnnotations;

namespace IPL2.Models
{
    public class Team
    {
        [Key]
        public int TeamId { get; set; }

        [Required]
        [StringLength(50)]
        public string TeamName { get; set; }

        [Required]
        [StringLength(50)]
        public string Coach { get; set; }

        [Required]
        [StringLength(100)]
        public string HomeGround { get; set; }

        [Required]
        public int FoundedYear { get; set; }

        [Required]
        [StringLength(50)]
        public string Owner { get; set; }
    }
}
